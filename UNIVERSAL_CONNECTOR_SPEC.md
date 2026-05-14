# Universal Connector System Specification

## Vision

A standardized 24-pin interconnect system that enables any cable to connect to any device through modular adapters. Built on the CableRack insert form factor.

## System Overview

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   DEVICE        │     │   UNIVERSAL     │     │   CABLE         │
│   (Laptop,      │────▶│   24-PIN        │◀────│   (USB-C,       │
│    Phone, TV)   │     │   INTERFACE     │     │    HDMI, etc.)  │
└─────────────────┘     └─────────────────┘     └─────────────────┘
        │                       │                       │
        ▼                       ▼                       ▼
  Original Port          Adapter Insert          Universal Male
  (unchanged)            with routing PCB         Terminator
```

### Components

| Component | Description |
|-----------|-------------|
| **Device Adapter Insert** | Accepts original male connector, routes to 24-pin rear interface |
| **Universal Male Terminator** | Replaces proprietary cable ends with standardized 24-pin plug |
| **Pass-Through Insert** | 24-pin female-to-female for cable extension |

---

## 24-Pin Interface Specification

### Physical Dimensions

```
Connector Housing: 16mm × 6mm × 4mm (fits in insert rear)
Pin Pitch: 1.27mm (0.05") - standard fine-pitch
Pin Array: 2 rows × 12 pins
Contact Type: Spring-loaded pogo pins (female) / Gold-plated pads (male)
Insertion Force: <3N
Rated Cycles: 10,000+
```

### Pin Layout (View from rear of insert, looking at female connector)

```
        ┌─────────────────────────────────────────────────────┐
        │  1   2   3   4   5   6   7   8   9  10  11  12      │
  TOP   │  ●   ●   ●   ●   ●   ●   ●   ●   ●   ●   ●   ●      │
  ROW   │ GND VCC VCC D-  D+ SS1 SS1 SS2 SS2 CC1 CC2 SBU     │
        │     5V  20V     TX- TX+ RX- RX+                     │
        ├─────────────────────────────────────────────────────┤
        │ 13  14  15  16  17  18  19  20  21  22  23  24      │
 BOTTOM │  ●   ●   ●   ●   ●   ●   ●   ●   ●   ●   ●   ●      │
  ROW   │ GND GND ML0 ML0 ML1 ML1 ML2 ML2 ML3 ML3 AUX HPD    │
        │         -   +   -   +   -   +   -   +   CH         │
        └─────────────────────────────────────────────────────┘
```

### Pin Definitions

| Pin | Name | Function | Max Rating |
|-----|------|----------|------------|
| **Power** ||||
| 1 | GND | Ground reference | - |
| 2 | VCC_5V | 5V power rail | 3A (15W) |
| 3 | VCC_HV | High voltage (9V/12V/20V) | 5A (100W) |
| 13 | GND | Ground return (power) | 5A |
| 14 | GND | Ground return (signal) | - |
| **USB 2.0** ||||
| 4 | D- | USB 2.0 Data Minus | 480 Mbps |
| 5 | D+ | USB 2.0 Data Plus | 480 Mbps |
| **USB 3.x SuperSpeed** ||||
| 6 | SSTX- | SuperSpeed TX- | 10 Gbps |
| 7 | SSTX+ | SuperSpeed TX+ | 10 Gbps |
| 8 | SSRX- | SuperSpeed RX- | 10 Gbps |
| 9 | SSRX+ | SuperSpeed RX+ | 10 Gbps |
| **Control** ||||
| 10 | CC1 | Configuration Channel 1 | USB-C negotiation |
| 11 | CC2 | Configuration Channel 2 | USB-C negotiation |
| 12 | SBU | Sideband Use | Alt mode signaling |
| 24 | HPD | Hot Plug Detect | Video presence |
| **Video/Main Link (DisplayPort/HDMI)** ||||
| 15 | ML0- | Main Link Lane 0 - | 8.1 Gbps |
| 16 | ML0+ | Main Link Lane 0 + | 8.1 Gbps |
| 17 | ML1- | Main Link Lane 1 - | 8.1 Gbps |
| 18 | ML1+ | Main Link Lane 1 + | 8.1 Gbps |
| 19 | ML2- | Main Link Lane 2 - | 8.1 Gbps |
| 20 | ML2+ | Main Link Lane 2 + | 8.1 Gbps |
| 21 | ML3- | Main Link Lane 3 - | 8.1 Gbps |
| 22 | ML3+ | Main Link Lane 3 + | 8.1 Gbps |
| 23 | AUX | Auxiliary Channel | DDC/EDID |

---

## Protocol Support Matrix

### Passive Routing (No Active Electronics)

| Protocol | Support | Pins Used | Notes |
|----------|---------|-----------|-------|
| USB 2.0 | ✅ Full | 1, 4, 5, 13 | Direct wire routing |
| USB 3.0 (5 Gbps) | ✅ Full | 1, 4-9, 13 | Requires impedance matching |
| USB 3.1 (10 Gbps) | ⚠️ Limited | 1, 4-9, 13 | Cable length <1m recommended |
| USB-C PD (100W) | ✅ Full | 1-3, 10-13 | Requires PD controller IC |
| Lightning | ✅ Full | 1, 2, 4, 5, 13 | USB 2.0 internally |
| 3.5mm Audio | ✅ Full | 4, 5, 14 (repurposed) | Analog, no data |
| DisplayPort 1.2 | ✅ Full | 13-24 | 4 lanes @ 5.4 Gbps |
| DisplayPort 1.4 | ⚠️ Limited | 13-24 | 4 lanes @ 8.1 Gbps, short cables |
| HDMI 1.4 | ⚠️ Requires conversion | 13-24 | TMDS ↔ DP conversion needed |
| HDMI 2.0+ | ❌ Active required | - | Needs protocol converter IC |
| Thunderbolt | ❌ Not supported | - | Active cables, authentication |
| Ethernet | ❌ Not supported | - | Would need 8 dedicated pairs |

### Active Adapters (With Embedded Electronics)

For HDMI support, adapter inserts would contain:
- TMDS to DisplayPort level shifter IC
- EDID EEPROM
- 3.3V regulator

---

## Insert Design Specifications

### Device Adapter Insert (Female Original → 24-Pin Female Rear)

```
FRONT VIEW                         SIDE CROSS-SECTION
┌────────────────────┐            ┌────────────────────┐
│  ┌──────────────┐  │            │▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│ ← Shell
│  │   Original   │  │            │  ┌──────────────┐  │
│  │  Connector   │  │            │  │   Connector  │══╪═► Cable plugs here
│  │   Opening    │  │            │  │    Socket    │  │
│  └──────────────┘  │            │  └──────┬───────┘  │
│                    │            │         │ PCB      │
│  ┌──────────────┐  │            │  ┌──────┴───────┐  │
│  │  [24-pin]    │  │            │  │ Signal Route │  │
│  │   Female     │  │            │  │    Board     │  │
│  └──────────────┘  │            │  └──────┬───────┘  │
│ [snap]      [snap] │            │  ┌──────┴───────┐  │
└────────────────────┘            │  │  24-Pin Conn │◀═╪═ Universal cable
                                  │  └──────────────┘  │
                                  └────────────────────┘
```

### Internal PCB Specifications

| Parameter | Wide Insert | Narrow Insert |
|-----------|-------------|---------------|
| Max PCB Size | 26mm × 11mm | 10mm × 11mm |
| PCB Thickness | 1.0mm (4-layer) | 0.8mm (4-layer) |
| Layer Stack | SIG-GND-GND-SIG | SIG-GND-GND-SIG |
| Impedance | 90Ω differential | 90Ω differential |
| Trace Width | 0.15mm (diff pairs) | 0.12mm (diff pairs) |
| Via Size | 0.3mm drill | 0.25mm drill |

### Signal Integrity Requirements

For high-speed video (8+ Gbps per lane):
- Differential pair impedance: 90Ω ±10%
- Insertion loss: <3dB at 4 GHz
- Return loss: >15dB
- Crosstalk: <-30dB
- Length matching: ±0.5mm within pairs

---

## Universal Male Terminator

The cable-side connector that replaces original plugs:

```
┌─────────────────────────────────────┐
│          CABLE ENTRY                │
│              ║                      │
│         ┌────╨────┐                 │
│         │  Strain │                 │
│         │  Relief │                 │
│         └────┬────┘                 │
│         ┌────┴────┐                 │
│         │  Wire   │                 │
│         │ Routing │                 │
│         │   PCB   │                 │
│         └────┬────┘                 │
│         ┌────┴────┐                 │
│         │ 24-Pin  │                 │
│         │  Male   │●●●●●●●●●●●●     │
│         │ Contact │●●●●●●●●●●●●     │
│         └─────────┘                 │
└─────────────────────────────────────┘

Dimensions: 20mm × 8mm × 6mm
```

### Wire Gauge Requirements

| Function | AWG | Max Current | Max Length |
|----------|-----|-------------|------------|
| Power (100W) | 18 | 5A | 2m |
| Power (60W) | 20 | 3A | 2m |
| USB 2.0 Data | 28 | - | 5m |
| USB 3.x Data | 26 (shielded) | - | 2m |
| Video Lanes | 26 (shielded) | - | 2m |
| Ground | 18 | 5A | 2m |

---

## Connector Routing Tables

### USB-C Adapter (Full Featured)

| USB-C Pin | Function | → 24-Pin |
|-----------|----------|----------|
| A1, B1, A12, B12 | GND | 1, 13, 14 |
| A4, B4 | VBUS | 2, 3 |
| A5 | CC1 | 10 |
| B5 | CC2 | 11 |
| A6, B6 | D+ | 5 |
| A7, B7 | D- | 4 |
| A2 | SSTX1+ | 7 |
| A3 | SSTX1- | 6 |
| B10 | SSRX2+ | 9 |
| B11 | SSRX2- | 8 |
| A8 | SBU1 | 12 |
| B8 | SBU2 | 12 |

### HDMI Adapter (Requires Active Conversion)

| HDMI Pin | Function | → 24-Pin (via converter) |
|----------|----------|--------------------------|
| 1, 2, 3 | TMDS Data2 | ML2+, ML2- (converted) |
| 4, 5, 6 | TMDS Data1 | ML1+, ML1- (converted) |
| 7, 8, 9 | TMDS Data0 | ML0+, ML0- (converted) |
| 10, 11, 12 | TMDS Clock | (embedded in DP stream) |
| 13 | CEC | Not mapped |
| 14 | Reserved | - |
| 15, 16 | DDC | AUX |
| 17 | GND | 13, 14 |
| 18 | +5V | 2 |
| 19 | HPD | 24 |

### DisplayPort Adapter (Native)

| DP Pin | Function | → 24-Pin |
|--------|----------|----------|
| 1, 3 | ML0+, ML0- | 16, 15 |
| 4, 6 | ML1+, ML1- | 18, 17 |
| 7, 9 | ML2+, ML2- | 20, 19 |
| 10, 12 | ML3+, ML3- | 22, 21 |
| 15, 17 | AUX+, AUX- | 23 |
| 18 | HPD | 24 |
| 2, 5, 8, 11, 14 | GND | 13, 14 |
| 20 | DP_PWR | 2 |

### USB-A 3.0 Adapter

| USB-A Pin | Function | → 24-Pin |
|-----------|----------|----------|
| 1 | VBUS | 2 |
| 2 | D- | 4 |
| 3 | D+ | 5 |
| 4 | GND | 1 |
| 5 | SSRX- | 8 |
| 6 | SSRX+ | 9 |
| 7 | GND_DRAIN | 13 |
| 8 | SSTX- | 6 |
| 9 | SSTX+ | 7 |

### Lightning Adapter (USB 2.0 + Charging)

| Lightning Pin | Function | → 24-Pin |
|---------------|----------|----------|
| 1 | GND | 1, 13 |
| 2 | L0p (Data) | 5 |
| 3 | L0n (Data) | 4 |
| 4 | ID0 | 10 |
| 5 | PWR | 2 |
| 6 | L1n | NC |
| 7 | L1p | NC |
| 8 | ID1 | 11 |

### 3.5mm Audio Jack (TRS/TRRS)

| Ring | Function | → 24-Pin |
|------|----------|----------|
| Tip | Left / Mono | 4 (repurposed) |
| Ring 1 | Right | 5 (repurposed) |
| Ring 2 | Mic (TRRS) | 12 (repurposed) |
| Sleeve | Ground | 14 |

---

## Bill of Materials (Per Adapter Type)

### Passive USB-C Adapter

| Component | Qty | Est. Cost |
|-----------|-----|-----------|
| 24-pin female connector | 1 | $0.80 |
| USB-C receptacle | 1 | $0.50 |
| 4-layer PCB (26×11mm) | 1 | $0.30 |
| 3D printed housing | 1 | $0.20 |
| **Total** | | **~$1.80** |

### Active HDMI Adapter

| Component | Qty | Est. Cost |
|-----------|-----|-----------|
| 24-pin female connector | 1 | $0.80 |
| HDMI Type-A receptacle | 1 | $0.60 |
| TMDS-to-DP converter IC | 1 | $3.50 |
| 3.3V LDO regulator | 1 | $0.15 |
| Passives (caps, resistors) | ~10 | $0.20 |
| 4-layer PCB | 1 | $0.50 |
| 3D printed housing | 1 | $0.20 |
| **Total** | | **~$5.95** |

### Universal Male Terminator

| Component | Qty | Est. Cost |
|-----------|-----|-----------|
| 24-pin male contact array | 1 | $1.00 |
| 2-layer routing PCB | 1 | $0.20 |
| Strain relief | 1 | $0.15 |
| Overmolded housing | 1 | $0.30 |
| **Total** | | **~$1.65** |

---

## Certification Requirements

### Safety & EMC

| Certification | Scope | Requirement |
|---------------|-------|-------------|
| UL 62368-1 | Audio/Video/IT equipment | Required for US/Canada |
| IEC 62368-1 | International safety | Required for EU/intl |
| FCC Part 15 | EMC (USA) | Required |
| CE Mark | EMC + Safety (EU) | Required |
| RoHS | Hazardous substances | Required |

### Protocol Compliance (Optional but Recommended)

| Certification | Fee Range | Notes |
|---------------|-----------|-------|
| USB-IF | $5,000+ | Required to use USB logo |
| HDMI Licensing | $10,000+/yr | Required to use HDMI trademark |
| DisplayPort | Included in VESA membership | ~$5,000/yr |

---

## Development Phases

### Phase 1: Proof of Concept
- [ ] Design 24-pin connector footprint
- [ ] Modify insert_base.scad for PCB cavity
- [ ] Create USB-C passive adapter insert
- [ ] Create universal male terminator housing
- [ ] Test USB 2.0 + power delivery

### Phase 2: High-Speed Data
- [ ] Design impedance-controlled PCBs
- [ ] USB 3.0 adapter insert
- [ ] DisplayPort adapter insert (native routing)
- [ ] Signal integrity testing

### Phase 3: Video Support
- [ ] HDMI active adapter (with converter IC)
- [ ] Full DisplayPort 1.4 validation
- [ ] Multi-protocol cable assemblies

### Phase 4: Certification & Production
- [ ] EMC pre-compliance testing
- [ ] Safety certification
- [ ] Injection-molded housings
- [ ] Production tooling

---

## Open Questions

1. **Connector gender convention**: Should the "frame side" always be female?
2. **Keying**: Add physical keying to prevent misalignment?
3. **Locking mechanism**: Friction fit or latching?
4. **Hot-swap protection**: Add TVS diodes for ESD?
5. **Power negotiation**: Embed USB-C PD controller in every adapter?

---

## References

- USB Type-C Specification Rev 2.1
- USB Power Delivery Specification Rev 3.1
- DisplayPort Standard 1.4a
- HDMI Specification 2.1
- USB-IF Cable and Connector Class Documents

---

*Document Version: 0.1 (Draft)*
*Last Updated: 2026-01-25*
