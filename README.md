# Enhanced 1.12.1 Client Addon Suite

[![Interface: 1.12.1](https://img.shields.io/badge/Interface-1.12.1%20(5875)-orange.svg)](#)
[![Suite Version: 2026.1](https://img.shields.io/badge/Suite-Modernized%202026-brightgreen.svg)](#)
[![ClassicAPI: v1.14.0+](https://img.shields.io/badge/ClassicAPI-v1.14.0+-green.svg)](https://github.com/brues-code/ClassicAPI)
[![SuperWoW: v2.2+](https://img.shields.io/badge/SuperWoW-v2.2+-brightgreen.svg)](https://github.com/balakethelock/SuperWoW)
[![NamPower: v4.6.3+](https://img.shields.io/badge/NamPower-v4.6.3+-blueviolet.svg)](https://github.com/Emyrk/nampower)
[![UnitXP: SP3](https://img.shields.io/badge/UnitXP-SP3-teal.svg)](https://codeberg.org/konaka/UnitXP_SP3)
[![DXVK: Vulkan](https://img.shields.io/badge/DXVK-Vulkan-red.svg)](https://github.com/doitsujin/dxvk)
[![Maintainer: Fostercare5988](https://img.shields.io/badge/Maintainer-Fostercare5988-blue.svg)](https://github.com/Fostercare5988)

An enterprise-grade, high-performance ecosystem of 7 modernized addons engineered natively for **World of Warcraft 1.12.1 (Build 5875)** running on the **Enhanced Client Extension Stack**.

Every addon in this suite has been re-architected from the ground up: legacy 2006 `OnUpdate` polling frames, destructive API monkey-patching, multi-locale bloat, and tooltip-scraping hacks have been completely eradicated in favor of native C++ hardware timers, strict memory recycling (`table.wipe`), secure hooks (`hooksecurefunc`), and direct engine events.

---

## 1. Master Addon Index

| Addon | Version | Category | GitHub Repository | Primary Capability |
| :--- | :---: | :--- | :--- | :--- |
| **[ItemRack](https://github.com/Fostercare5988/ItemRack)** | `1.99.1` | Equipment & Sets | [Fostercare5988/ItemRack](https://github.com/Fostercare5988/ItemRack) | Equipment sets, dynamic HUD bar, automated stance/mount triggers, and asynchronous combat queueing. |
| **[Bagnon](https://github.com/Fostercare5988/Bagnon)** | `1.5.1` | Inventory & Storage | [Fostercare5988/Bagnon](https://github.com/Fostercare5988/Bagnon) | Unified single-window inventory & bank, remote bank caching, instant search, and cross-alt gold/item tracking. |
| **[TrinketMenu](https://github.com/Fostercare5988/TrinketMenu)** | `3.9.1` | Equipment & Cooldowns | [Fostercare5988/TrinketMenu](https://github.com/Fostercare5988/TrinketMenu) | Trinket management bar, drawer flyout, intelligent auto-queue rotation, and race-free combat queueing. |
| **[AutoLazy](https://github.com/Fostercare5988/AutoLazy)** | `3.6.1` | Automation & QoL | [Fostercare5988/AutoLazy](https://github.com/Fostercare5988/AutoLazy) | Dungeon loot automation, Shift-hold repeatable quest chaining, Floating Addon Tray, and client bloat suppression. |
| **[AutoBG](https://github.com/Fostercare5988/AutoBG)** | `1.7.0` | PvP Suite | [Fostercare5988/AutoBG](https://github.com/Fostercare5988/AutoBG) | All-in-one PvP suite: auto-queueing, auto-accept, graveyard release, full built-in enemy unit frames (WSG/AB/AV), flag carrier focus, and stealth spy radar. |
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
│   AutoBG    │       │     MSBT      │◄─────►│   TWThreat    │
│(PvP & Units)│       │ (Combat Text) │ Threat│ (Raid Meter)  │
└─────────────┘       └───────────────┘       └───────────────┘
```

### Synergy 1: The Gear & Inventory Trinity (`Bagnon` + `ItemRack` + `TrinketMenu`)
This trio provides a completely unified, zero-friction inventory and equipment lifecycle:

* **Universal Bank Synchronization (`Bagnon` + `ItemRack`)**:
  - ItemRack never inspects Blizzard's default bag or bank frames; it listens directly to engine events (`BANKFRAME_OPENED` and `BANKFRAME_CLOSED`).
  - When Bagnon's unified bank (`Banknon`) opens, ItemRack activates its banking mode automatically with zero frame collision.
  - Banked items belonging to ItemRack sets display a distinct **blue border** in ItemRack menus.
  - Clicking a set in ItemRack while at the bank deposits or withdraws all set items in one click, and Bagnon's unified grid updates instantly via native `BAG_UPDATE` and `PLAYERBANKSLOTS_CHANGED` dispatches.
* **Smart Tooltip Telemetry (`Bagnon` + `ItemRack` + `TrinketMenu`)**:
  - **ItemRack Set Membership**: Hovering over any item in your bags or bank via Bagnon displays which saved sets the item belongs to (`ItemRack: <Set Names>`), preventing accidental vendor sales or disenchants.
  - **TrinketMenu Staged Queues**: Hovering over an unequipped trinket currently staged for swap displays a gold alert (`TrinketMenu: Queued (Top/Bottom Slot)`).
* **Cooperative Non-Destructive Hooking**:
  - Both `ItemRack` and `TrinketMenu` utilize ClassicAPI `hooksecurefunc("UseInventoryItem")` and `hooksecurefunc("UseAction")`.
  - Action button usage is resolved directly via C++ `GetActionInfo(slot)` Item ID matching, completely eradicating tooltip parsing overhead.
* **Cooperative Swap Scheduling & Lock Contention Shield**:
  - If you exit combat (`PLAYER_REGEN_ENABLED`) while both an ItemRack set swap and TrinketMenu trinket queue are pending, TrinketMenu politely yields execution while ItemRack is in mid-swap (`Rack.SetSwapping`).
  - When ItemRack finishes equipping all gear pieces, it immediately notifies TrinketMenu (`TrinketMenu.UpdateWornTrinkets()`), allowing TrinketMenu to process any remaining trinket swaps with 0ms visual latency and zero cursor deadlocks.
  - **Pro-Tip**: In ItemRack, Alt+Click slots 13 and 14 when saving general gear sets (PvP, PvE, Tanking) to ignore trinket slots. This grants TrinketMenu 100% autonomous control over trinket rotations without set swaps overwriting your active cooldown trinkets.

### Synergy 2: The Competitive PvP Dominance Pair (`AutoBG` + `ItemRack`)
Engineered specifically for high-tempo battleground play:

* **All-in-One Tactical PvP Platform (`AutoBG`)**:
  - `AutoBG` completely eliminates the need for separate target frames like BattlegroundTargets by embedding native, hardware-accelerated enemy unit frames directly (`AutoBG_Targets.lua`).
  - Provides real-time enemy class coloring, health/mana resource tracking, enemy stealth radar (`AutoBG_Spy.lua`), and automated flag-carrier tracking (`AutoBG_FC.lua`) across WSG, AB, and AV.
  - Handles automated queue entry, 1-click auto-accept, and instant graveyard spirit release.
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
  - AutoLazy includes a collapsible HUD button that docks shortcuts for `ItemRack`, `TrinketMenu`, `Bagnon`, and `AutoBG`, keeping your screen pristine while retaining 1-click access to all configurations.
* **System Bloat & Stutter Suppression**:
  - AutoLazy includes native memory garbage collection throttling, ensuring heavy combat encounters (raids and 40v40 Alterac Valley) run at smooth DXVK Vulkan framerates without micro-stutter.

---

## 3. Cross-Compatibility Matrix

| Addon | Bagnon | ItemRack | TrinketMenu | AutoLazy | AutoBG | MSBT | TWThreat |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Bagnon** | — | 🟢 Native | 🟢 Native | 🟢 Synergy | ⚪ Clean | ⚪ Clean | ⚪ Clean |
| **ItemRack** | 🟢 Native | — | 🟢 Co-Op | 🟢 Dockable | 🟢 Synergy | 🟢 Audio/Vis | ⚪ Clean |
| **TrinketMenu**| 🟢 Native | 🟢 Co-Op | — | 🟢 Dockable | ⚪ Clean | 🟢 Alert Sync| ⚪ Clean |
| **AutoLazy** | 🟢 Synergy| 🟢 Dockable| 🟢 Dockable | — | 🟢 Co-Op | ⚪ Clean | ⚪ Clean |
| **AutoBG** | ⚪ Clean | 🟢 Synergy| ⚪ Clean | 🟢 Co-Op | — | ⚪ Clean | ⚪ Clean |
| **MSBT** | ⚪ Clean | 🟢 Audio/Vis| 🟢 Alert Sync| ⚪ Clean | ⚪ Clean | — | 🟢 Co-Op |
| **TWThreat** | ⚪ Clean | ⚪ Clean | ⚪ Clean | ⚪ Clean | ⚪ Clean | 🟢 Co-Op | — |

**Legend:**
- 🟢 **Native / Co-Op / Synergy**: Active interoperability, complementary features, or direct event-level coordination.
- ⚪ **Clean**: Fully independent, zero memory overlap, zero hook conflicts, zero global namespace collisions.

---

## 4. Architectural Standards (Why They Never Break)

All 7 addons adhere to the strict **Enhanced 1.12.1 Engine Architecture Standards**:

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

## 5. Installation & Deployment

### Mandatory Prerequisites
This suite is engineered natively for World of Warcraft 1.12.1 running the Enhanced Client Extension Stack:
1. [**ClassicAPI v1.14.0+**](https://github.com/brues-code/ClassicAPI) — Mandatory engine DLL.
2. [**SuperWoW v2.2+**](https://github.com/balakethelock/SuperWoW) — Mandatory engine DLL.
3. [**NamPower v4.6.3+**](https://github.com/Emyrk/nampower) — Mandatory engine DLL.
4. [**UnitXP SP3 v89+**](https://codeberg.org/konaka/UnitXP_SP3) — Mandatory engine DLL.
5. [**DXVK**](https://github.com/doitsujin/dxvk) & [**VanillaFixes**](https://github.com/hannesmann/vanillafixes) — Vulkan translation layer and modern OS framerate uncap.

### Quick Install (One-Click PowerShell)
To clone and deploy all 7 addons directly to your World of Warcraft client:
```powershell
# Clone the complete suite with all submodules
git clone --recursive https://github.com/Fostercare5988/fostercare-addon-suite.git

# Deploy into your Interface\AddOns folder
cd fostercare-addon-suite
.\Install-Suite.ps1 -TargetDir "C:\Path\To\World of Warcraft 1.12.1\Interface\AddOns"
```

### Updating All Addons
To pull the latest updates across all 7 repositories in one command:
```bash
git submodule update --remote --merge
```

---

## 6. Credits & License

- **Curator & Maintainer**: [Fostercare5988](https://github.com/Fostercare5988)
- **Engine Contributors**: Brues (ClassicAPI), Balake (SuperWoW), Emyrk (NamPower), Konaka (UnitXP), McPewPew, Gello, Tuller
- **License**: GNU General Public License v2 (GPL-2.0)
