{ config, lib, ... }:

{
  options.dotfiles.features.claude-code.enable = lib.mkEnableOption "claude-code";

  config = lib.mkIf config.dotfiles.features.claude-code.enable {
    programs.claude-code = {
      enable = true;
      memory.text = ''
        # Instructions for Claude Code

        ## Core Philosophy: Iterative & Minimal

        **The Goal:** Build incrementally. User provides the "what" and "next step." Claude provides the smallest working implementation.

        ### 1. The "MVP" Standard
        * **Strict Scope:** Modify *only* the files necessary for the current instruction.
        * **No "Future-Proofing":** Do not refactor for extensibility. Do not add configuration hooks for features that don't exist yet.
        * **Simple over Clever:** Prefer a hardcoded value or a simple `if` statement over a new class structure or design pattern.

        ### 2. Code Style & Integrity
        * **Match Existing Style:** Follow the existing indentation, naming conventions, and typing strictness.
        * **Error Handling:** Implement basic "fail-fast" error handling. Do not build complex recovery/retry logic unless asked.

        ### 3. Prohibited (Unless Explicitly Requested)
        * Refactoring code outside the immediate diff context.
        * Adding libraries/dependencies.
        * Adding logging frameworks, analytics, or telemetry.
        * Writing comprehensive test suites (writing a single verify script is okay).
        * Updating documentation/comments (unless the change makes existing docs misleading).

        ### 4. Communication Protocol
        * **Stop and Ask:** If a change requires touching more than 3 files or refactoring a core utility, stop and propose the plan first.
        * **Trade-offs:** If taking a shortcut (e.g., hardcoding), add a TODO comment (e.g., `// TODO: [CLAUDE] hardcoded as currently designed to accept only a single item`).
        * **Rule Violations:** Explicitly state when deviating from Rules 1-3 and explain why it's necessary. Example: "Breaking MVP Standard (future-proofing) because the existing architecture requires this abstraction to add the requested feature."
      '';
    };
  };
}
