import dev.robocode.tankroyale.runner.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Debug battle to verify Nim Walls gun-alignment fix across rounds.
 *
 * Runs 3 rounds: Walls (Nim) vs SpinBot (Nim) vs Fire (Nim).
 * Prints body/gun direction for "Walls (Nim)" for the first 20 turns of each round,
 * then prints per-round intent diagnostics (gunTurnRate, targetSpeed, turnRate).
 *
 * Usage (from runner/examples/):
 *   java -cp lib/* DebugWallsBattle.java
 */
public class DebugWallsBattle {

    static final String NIM_WALLS_NAME = "Walls (Nim)";
    static final int    PRINT_TURNS    = 20;

    // id → display-name, built from GameStartedEvent participants
    static final Map<Integer, String> idToName       = new ConcurrentHashMap<>();
    // round → how many turns we've already printed for that round
    static final Map<Integer, AtomicInteger> roundTurnCount = new ConcurrentHashMap<>();

    public static void main(String[] args) {
        Logger.getLogger("dev.robocode.tankroyale").setLevel(Level.WARNING);

        var nimBotsDir  = "/home/davide/Projects/tank-royale/bot-api/nim/sample_bots";

        try (var runner = BattleRunner.create(b -> b
                .embeddedServer()
                .suppressServerOutput()
                .enableIntentDiagnostics())) {

            var setup = BattleSetup.classic(s -> s.setNumberOfRounds(3));
            var bots = List.of(
                    BotEntry.of(nimBotsDir + "/Walls"),
                    BotEntry.of(nimBotsDir + "/SpinBot"),
                    BotEntry.of(nimBotsDir + "/Fire")
            );

            var owner = new Object();

            try (var handle = runner.startBattleAsync(setup, bots)) {

                // ── Participant map ──────────────────────────────────────────
                handle.getOnGameStarted().on(owner, event -> {
                    System.out.println("=== GAME STARTED ===");
                    for (var p : event.getParticipants()) {
                        idToName.put(p.getId(), p.getName());
                        System.out.printf("  #%d  %s%n", p.getId(), p.getName());
                    }
                    System.out.println();
                });

                // ── Round header ─────────────────────────────────────────────
                handle.getOnRoundStarted().on(owner, event -> {
                    int round = event.getRoundNumber();
                    roundTurnCount.put(round, new AtomicInteger(0));
                    System.out.printf("%n=== ROUND %d STARTED ===%n", round);
                    System.out.printf("%-5s  %-10s  %-10s  %-10s  %-12s  %-8s%n",
                            "Turn", "BodyDir", "GunDir", "GunOffset", "GunTurnRate", "Speed");
                    System.out.println("-".repeat(65));
                });

                handle.getOnRoundEnded().on(owner, event ->
                        System.out.printf("=== ROUND %d ENDED (turn %d) ===%n%n",
                                event.getRoundNumber(), event.getTurnNumber()));

                // ── Per-tick state for Walls (Nim) ───────────────────────────
                handle.getOnTickEvent().on(owner, event -> {
                    int round = event.getRoundNumber();
                    int turn  = event.getTurnNumber();

                    var counter = roundTurnCount.get(round);
                    if (counter == null || counter.get() >= PRINT_TURNS) return;

                    for (var state : event.getBotStates()) {
                        // Resolve name: prefer the participant map; fall back to inline name
                        String name = idToName.getOrDefault(
                                state.getId(),
                                state.getName() != null ? state.getName() : "?");
                        if (!NIM_WALLS_NAME.equals(name)) continue;

                        counter.incrementAndGet();

                        double bodyDir = state.getDirection();
                        double gunDir  = state.getGunDirection();
                        double offset  = gunDir - bodyDir;
                        while (offset >  180) offset -= 360;
                        while (offset < -180) offset += 360;

                        System.out.printf("%-5d  %-10.2f  %-10.2f  %-10.2f  %-12.4f  %-8.2f%n",
                                turn, bodyDir, gunDir, offset,
                                state.getGunTurnRate(), state.getSpeed());
                    }
                });

                // ── Await completion ─────────────────────────────────────────
                var results = handle.awaitResults();
                System.out.printf("%n=== FINAL RESULTS (%d rounds) ===%n", results.getNumberOfRounds());
                for (var r : results.getResults()) {
                    System.out.printf("  #%d  %-20s  %d pts%n",
                            r.getRank(), r.getName(), r.getTotalScore());
                }
            }

            // ── Intent diagnostics ───────────────────────────────────────────
            var store = runner.getIntentDiagnostics();
            if (store == null) {
                System.out.println("\nNo intent diagnostics available.");
                return;
            }

            System.out.printf("%n=== INTENT DIAGNOSTICS: %s ===%n", NIM_WALLS_NAME);
            var intents = store.getIntentsForBot(NIM_WALLS_NAME);
            if (intents == null || intents.isEmpty()) {
                System.out.println("No intents captured for " + NIM_WALLS_NAME + ".");
                System.out.println("Captured bots: " + store.botNames());
                return;
            }

            System.out.printf("Total intents captured: %d%n%n", intents.size());
            System.out.printf("%-6s  %-6s  %11s  %10s  %12s  %11s%n",
                    "Round", "Turn", "TargetSpd", "TurnRate", "GunTurnRate", "Firepower");
            System.out.println("-".repeat(65));

            int prevRound = -1, roundCount = 0;
            for (var ci : intents) {
                int r = ci.getRoundNumber();
                if (r != prevRound) {
                    prevRound  = r;
                    roundCount = 0;
                    System.out.printf("%n--- Round %d ---%n", r);
                }
                if (roundCount++ >= PRINT_TURNS) continue;

                var intent = ci.getIntent();
                System.out.printf("%-6d  %-6d  %11s  %10s  %12s  %11s%n",
                        r, ci.getTurnNumber(),
                        fmt(intent.getTargetSpeed()),
                        fmt(intent.getTurnRate()),
                        fmt(intent.getGunTurnRate()),
                        fmt(intent.getFirepower()));
            }
        }
    }

    static String fmt(Double v) {
        return v != null ? String.format("%+.4f", v) : "null";
    }
}
