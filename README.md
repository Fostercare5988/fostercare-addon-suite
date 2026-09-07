# Enhanced 1.12.1 Client Addon Suite

[![Interface: 1.12.1](https://img.shields.io/badge/Interface-1.12.1%20(5875)-orange.svg)](#)
[![Suite Version: 2026.1](https://img.shields.io/badge/Suite-Modernized%202026-brightgreen.svg)](#)
[![ClassicAPI: v1.14.0+](https://img.shields.io/badge/ClassicAPI-v1.14.0+-green.svg)](https://github.com/brues-code/ClassicAPI)
[![SuperWoW: v2.2+](https://img.shields.io/badge/SuperWoW-v2.2+-brightgreen.svg)](https://github.com/balakethelock/SuperWoW)
[![NamPower: v4.6.3+](https://img.shields.io/badge/NamPower-v4.6.3+-blueviolet.svg)](https://github.com/Emyrk/nampower)
[![UnitXP: SP3](https://img.shields.io/badge/UnitXP-SP3-teal.svg)](https://codeberg.org/konaka/UnitXP_SP3)
[![DXVK: Vulkan](https://img.shields.io/badge/DXVK-Vulkan-red.svg)](https://github.com/doitsujin/dxvk)
[![Maintainer: Fostercare5988](https://img.shields.io/badge/Maintainer-Fostercare5988-blue.svg)](https://github.com/Fostercare5988)

An enterprise-grade, high-performance ecosystem of 8 modernized addons engineered natively for **World of Warcraft 1.12.1 (Build 5875)** running on the **Enhanced Client Extension Stack**.

Every addon in this suite has been re-architected from the ground up: legacy 2006 `OnUpdate` polling frames, destructive API monkey-patching, multi-locale bloat, and tooltip-scraping hacks have been completely eradicated in favor of native C++ hardware timers, strict memory recycling (`table.wipe`), secure hooks (`hooksecurefunc`), and direct engine events.

---

## 1. Master Addon Index

| Addon | Version | Category | GitHub Repository | Primary Capability |
| :--- | :---: | :--- | :--- | :--- |
| **[ItemRack](https://github.com/Fostercare5988/ItemRack)** | `1.99.0` | Equipment & Sets | [Fostercare5988/ItemRack](https://github.com/Fostercare5988/ItemRack) | Equipment sets, dynamic HUD bar, automated stance/mount triggers, and asynchronous combat queueing. |
| **[Bagnon](https://github.com/Fostercare5988/Bagnon)** | `1.5.0` | Inventory & Storage | [Fostercare5988/Bagnon](https://github.com/Fostercare5988/Bagnon) | Unified single-window inventory & bank, remote bank caching, instant search, and cross-alt gold/item tracking. |
| **[TrinketMenu](https://github.com/Fostercare5988/TrinketMenu)** | `3.9.0` | Equipment & Cooldowns | [Fostercare5988/TrinketMenu](https://github.com/Fostercare5988/TrinketMenu) | Trinket management bar, drawer flyout, intelligent auto-queue rotation, and race-free combat queueing. |
| **[AutoLazy](https://github.com/Fostercare5988/AutoLazy)** | `3.6.1` | Automation & QoL | [Fostercare5988/AutoLazy](https://github.com/Fostercare5988/AutoLazy) | Dungeon loot automation, Shift-hold repeatable quest chaining, Floating Addon Tray, and client bloat suppression. |
| **[AutoBG](https://github.com/Fostercare5988/AutoBG)** | `1.7.0` | PvP Automation | [Fostercare5988/AutoBG](https://github.com/Fostercare5988/AutoBG) | Instant battleground auto-queueing, auto-accept, automated graveyard spirit releasing, and honor tracking. |
| **[BattlegroundTargets](https://github.com/Fostercare5988/BattlegroundTargets)** | `3.4.0` | PvP Unit Frames | [Fostercare5988/BattlegroundTargets](https://github.com/Fostercare5988/BattlegroundTargets) | High-performance enemy unit frames for WSG, AB, and AV with class colors, health/resource bars, and flag carrier focus. |
| **[MikScrollingBattleText](https://github.com/Fostercare5988/MikScrollingBattleText)** | `6.5.1` | Combat Telemetry | [Fostercare5988/MikScrollingBattleText](https://github.com/Fostercare5988/MikScrollingBattleText) | Zero-latency scrolling combat text, custom scroll areas, binary packet parsing via NamPower, and visual alerts. |
| **[TWThreat](https://github.com/Fostercare5988/TWThreat-Octo)** | `1.4.0` | PvE & Raiding | [Fostercare5988/TWThreat-Octo](https://github.com/Fostercare5988/TWThreat-Octo) | Server-authoritative real-time threat meter, SuperWoW GUID tracking, smooth bar animations, and zero garbage collection stutter. |

---

## 2. Addon Synergies & Functional Pairings

These addons are designed under a **Capability-First Architecture**: each component has high internal cohesion and low coupling with others, enabling them to communicate seamlessly through standard engine events without breaking or fighting for control.

```
                  ┌────────────────────────┐
                  │        AutoLazy        │ (Floating Tray & Master QoL)
                  └───────────┬────────────┘
                              │ Orchestrates UI
      ┌───────────────────────┼───────────────────────┐
      ▼                       ▼                       ▼
┌─────────────┐       ┌───────────────┐       ┌───────────────┐
│   Bagnon    │◄─────►│   ItemRack    │◄─────►│  TrinketMenu  │
│  (Storage)  │ Bank  │ (Gear & Sets) │ Queue │ (Trinket Rot) │
└─────────────┘       └───────┬───────┘       └───────┬───────┘
                              │                       │
      ┌───────────────────────┼───────────────────────┘
      │ Event Triggers        │ Cooldown Alerts
      ▼                       ▼
┌─────────────┐       ┌───────────────┐       ┌───────────────┐
│   AutoBG    │◄─────►│Battleground-  │       │     MSBT      │◄─────► TWThreat
│ (PvP Queue) │ Enter │    Targets    │       │ (Combat Text) │ Threat (Raid Meter)
└─────────────┘       └───────────────┘       └───────────────┘
```

### Synergy 1: The Gear & Inventory Trinity (`Bagnon` + `ItemRack` + `TrinketMenu`)
This trio provides a completely unified, zero-friction inventory and equipment lifecycle:

* **Universal Bank Synchronization (`Bagnon` + `ItemRack`)**:
  - ItemRack never inspects Blizzard's default bag or bank frames; it listens to engine events (`BANKFRAME_OPENED` and `BANKFRAME_CLOSED`).
  - When Bagnon's unified bank (`Banknon`) opens, ItemRack activates its banking mode automatically.
  - Banked items belonging to ItemRack sets display a distinct **blue border** in ItemRack menus.
  - Clicking a set in ItemRack while at the bank deposits or withdraws all set items in one click, and Bagnon's unified grid updates instantly via native `BAG_UPDATE` and `PLAYERBANKSLOTS_CHANGED` dispatches.
* **Macro vs Micro Equipment Management (`ItemRack` + `TrinketMenu`)**:
  - `ItemRack` handles full equipment sets (PvP, Tanking, Healing, Resistance, Mount speed, GBD specialization swaps).
  - `TrinketMenu` micro-manages individual trinket slot rotations, auto-swapping ready on-use trinkets when active ones go on cooldown.
  - Both addons share the same **asynchronous `ITEM_LOCK_CHANGED` state machine**: if you swap sets while TrinketMenu is queueing trinkets, neither addon deadlocks the cursor or drops swaps.

### Synergy 2: The Competitive PvP Dominance Pair (`AutoBG` + `BattlegroundTargets` + `ItemRack`)
Engineered specifically for high-tempo battleground play:

* **Automated Transit & Tactical Readiness (`AutoBG` + `BattlegroundTargets`)**:
  - `AutoBG` monitors queues, auto-accepts battleground invites, auto-releases at the graveyard, and minimizes scoreboard clutter.
  - The instant you zone in, `BattlegroundTargets` initializes enemy rosters across Warsong Gulch, Arathi Basin, and Alterac Valley, providing real-time enemy class, health, resource, and flag carrier targeting.
* **Contextual Gear Transition (`AutoBG` + `ItemRack`)**:
  - Zone transitions triggered by AutoBG fire ItemRack's zone-aware event scripts (configured via `Events.lua` / `EVENTS.md`), automatically equipping PvP trinkets, rocket boots, or flag-carrying resistance sets upon entering battlegrounds.

### Synergy 3: Combat Telemetry & Encounter Awareness (`MSBT` + `TWThreat` + `TrinketMenu`)
Delivers critical real-time combat intelligence with zero frame drops:

* **Threat & Sensory Feedback (`MSBT` + `TWThreat`)**:
  - `TWThreat` computes server-authoritative threat tables using SuperWoW GUIDs and NamPower packet parsing.
  - `MSBT` outputs high-priority visual notifications when you pull aggro, exceed tank threat thresholds, or when taunts/threat abilities resist.
* **Trinket Cooldown Audio/Visual Cues (`TrinketMenu` + `MSBT`)**:
  - As TrinketMenu rotates cooldown trinkets, MSBT announces trinket availability and on-use procs with high-visibility scrolling animations and optional audio chimes.

### Synergy 4: Master Addon Orchestration & QoL (`AutoLazy`)
`AutoLazy` serves as the central operational hub for the entire suite:

* **Floating Addon Tray**:
  - AutoLazy includes a collapsible HUD button that docks shortcuts for `ItemRack`, `TrinketMenu`, `Bagnon`, and `BattlegroundTargets`, keeping your screen pristine while retaining 1-click access to all configurations.
* **System Bloat & Stutter Suppression**:
  - AutoLazy includes native memory garbage collection throttling, ensuring heavy combat encounters (raids and 40v40 Alterac Valley) run at smooth DXVK Vulkan framerates without micro-stutter.

---

## 3. Cross-Compatibility Matrix

| Addon | Bagnon | ItemRack | TrinketMenu | AutoLazy | AutoBG | BG Targets | MSBT | TWThreat |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Bagnon** | — | 🟢 Native | 🟢 Native | 🟢 Synergy | ⚪ Clean | ⚪ Clean | ⚪ Clean | ⚪ Clean |
| **ItemRack** | 🟢 Native | — | 🟢 Co-Op | 🟢 Dockable | 🟢 Synergy | ⚪ Clean | 🟢 Audio/Vis | ⚪ Clean |
| **TrinketMenu**| 🟢 Native | 🟢 Co-Op | — | 🟢 Dockable | ⚪ Clean | ⚪ Clean | 🟢 Alert Sync| ⚪ Clean |
| **AutoLazy** | 🟢 Synergy| 🟢 Dockable| 🟢 Dockable | — | 🟢 Co-Op | 🟢 Co-Op | ⚪ Clean | ⚪ Clean |
| **AutoBG** | ⚪ Clean | 🟢 Synergy| ⚪ Clean | 🟢 Co-Op | — | 🟢 Seamless| ⚪ Clean | ⚪ Clean |
| **BG Targets**| ⚪ Clean | ⚪ Clean | ⚪ Clean | 🟢 Co-Op | 🟢 Seamless| — | ⚪ Clean | ⚪ Clean |
| **MSBT** | ⚪ Clean | 🟢 Audio/Vis| 🟢 Alert Sync| ⚪ Clean | ⚪ Clean | ⚪ Clean | — | 🟢 Co-Op |
| **TWThreat** | ⚪ Clean | ⚪ Clean | ⚪ Clean | ⚪ Clean | ⚪ Clean | ⚪ Clean | 🟢 Co-Op | — |

**Legend:**
- 🟢 **Native / Co-Op / Synergy**: Active interoperability, complementary features, or direct event-level coordination.
- ⚪ **Clean**: Fully independent, zero memory overlap, zero hook conflicts, zero global namespace collisions.

---

## 4. Architectural Standards (Why They Never Break)

All 8 addons adhere to the strict **OctoWoW Engine Architecture Standards**:

1. **Hardware C++ Dispatchers (`C_Timer`)**:
   Zero `OnUpdate` polling frames. Timers and delayed tasks utilize `C_Timer.After` and `C_Timer.NewTicker` provided by ClassicAPI, saving CPU cycles and battery life.
2. **Zero Tooltip Scraping**:
   Item, spell, and mount checks use direct Item IDs, spell IDs, or native C++ queries (`IsMounted()`, `C_UnitAuras.GetAuraDataByIndex`), eliminating invisible GameTooltip parsing.
3. **Lock-Sequenced Swapping**:
   Both `ItemRack` and `TrinketMenu` sequence item transactions through `ITEM_LOCK_CHANGED` engine callbacks, completely eliminating the vanilla cursor lock race condition.
4. **Strict Mouse Passthrough (Rule C8)**:
   Cooldown frames across all addons enforce `:EnableMouse(false)`, preventing invisible cooldown sweeps from intercepting player mouse clicks.
5. **Garbage-Free Memory Recycling**:
   Search filters and dynamic lists utilize native C++ `table.wipe(t)` instead of table allocations (`{}`), eliminating Lua garbage collection pauses during intensive combat.

---

## 5. Suggested Names for the Central GitHub Repository

To collect, showcase, and distribute this modernized suite under a unified umbrella on GitHub, here are curated name proposals:

### Option 1: `fostercare-addon-suite` (Recommended - Personal Brand)
* **Rationale**: Directly aligns with your GitHub username (`Fostercare5988`), establishing clear authorship, ownership, and credibility across the vanilla community.
* **Repository URL**: `https://github.com/Fostercare5988/fostercare-addon-suite`

### Option 2: `enhanced-112-addon-suite` or `enhanced-vanilla-suite` (Engine-Focused)
* **Rationale**: Immediately signals to players and developers that this suite is purpose-built for the Enhanced 1.12.1 Client stack (ClassicAPI, SuperWoW, NamPower, DXVK).
* **Repository URL**: `https://github.com/Fostercare5988/enhanced-112-addon-suite`

### Option 3: `apex-112-addons` (High-Performance Theme)
* **Rationale**: "Apex" conveys peak performance, zero bloat, and enterprise-grade architectural quality. Short, punchy, and memorable.
* **Repository URL**: `https://github.com/Fostercare5988/apex-112-addons`

### Option 4: `nexus-addon-suite` (Ecosystem Theme)
* **Rationale**: "Nexus" represents an interconnected central hub where all individual subsystems (inventory, gear, PvP, combat telemetry) interface harmoniously.
* **Repository URL**: `https://github.com/Fostercare5988/nexus-addon-suite`

### Option 5: `quantum-112-suite` (Modernization Theme)
* **Rationale**: Highlights the quantum leap from legacy 2006 Lua scripting to modern C++ engine acceleration.
* **Repository URL**: `https://github.com/Fostercare5988/quantum-112-suite`

---

## 6. Central Repository Distribution Strategy

For the central repository, you can set it up in either of two standard approaches:

1. **Meta-Catalog / Portal Repository (Simplest)**:
   - A single repository containing this comprehensive `README.md`, installation guide, and links to each individual addon repository.
   - Includes a one-click PowerShell / batch download script that clones or updates all 8 addons simultaneously into the player's `Interface\AddOns\` folder.
2. **Monorepo with Git Submodules**:
   - The central repository links each individual addon as a `git submodule`:
     ```bash
     git submodule add https://github.com/Fostercare5988/ItemRack.git ItemRack
     git submodule add https://github.com/Fostercare5988/Bagnon.git Bagnon
     git submodule add https://github.com/Fostercare5988/TrinketMenu.git TrinketMenu
     git submodule add https://github.com/Fostercare5988/AutoLazy.git AutoLazy
     git submodule add https://github.com/Fostercare5988/AutoBG.git AutoBG
     git submodule add https://github.com/Fostercare5988/BattlegroundTargets.git BattlegroundTargets
     git submodule add https://github.com/Fostercare5988/MikScrollingBattleText.git MikScrollingBattleText
     git submodule add https://github.com/Fostercare5988/TWThreat-Octo.git TWThreat
     ```
   - Allows users to clone the entire 8-addon suite in one command (`git clone --recursive ...`) while preserving each addon's independent repository and release cycle.
