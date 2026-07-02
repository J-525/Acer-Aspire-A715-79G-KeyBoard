# Acer-Aspire-A715-79G-KeyBoard
A potential Reverse Engineered script to change keyboard color by directly communicating  directly with Embedded Controller (EC)

  > [!NOTE]
  > This is Project Was Created with the help A.I so there will some some bugs and issues

  > [!WARNING]
  > This Project writes directly to Embedded Controller(EC) registers.Incorrect writes can cause system instability or unexpected hardware behaviour

# Tested hardware

Laptop:
 - Acer Aspire A715 79G 

Kernel:
- 7.0.14-zen1-1-zen

Desktop:
- Hyprland

# Working

Fnkey -> InsydeDCHU.dll -> Clevco Driver -> WINDOWS ACPI -> EC -> Keyboard RGB

  >This Program will directly write into EC instead of using InsydeDCHU.dll 

# Dependencies

## Kernel
Enable the EC driver:
```

sudo modprobe ec_sys write_support=1
```

To automatically load at boot:

```
/etc/modprobe.d/ec_sys.conf
```

```
options ec_sys write_support=1
```

```
/etc/modules-load.d/ec_sys.conf
```

```
ec_sys
```

Verify:

```bash
ls /sys/kernel/debug/ec/ec0
```

You should see:

```
io
```

If not, ensure debugfs is mounted:

```bash
sudo mount -t debugfs debugfs /sys/kernel/debug
```

# RGB Protocol

Current Protocol:
| Offset | Description     |
| ------ | --------------- |
| F8     | Execute command |
| F9     | Zone            |
| FA     | Blue            |
| FB     | Red             |
| FC     | Green           |
| FD     | Flags           |

Command:
```
CA 03 BB RR GG
```


(Current implementation writes Blue→0xFA, Red→0xFB, Green→0xFC.)

Zone:

```
0x03
```

> [!NOTE]
> In the fnkey.exe i found options for changing color in multiple zones hard coded .The exe will automatically detect your keyboard type and adjust setting accordingly so there might a chance the zone will be different even though we all use same model.
>So Please change the zone if the default zone is not working

# Usage

Example:

```bash
sudo rgb 255 0 0
```

Red.

```bash
sudo rgb 0 255 0
```

Green.

```bash
sudo rgb 0 0 255
```

Blue.

# Brightness Protocol

| Offset | Purpose          |
| ------ | ---------------- |
| `0xF8` | Command          |
| `0xF9` | Subcommand       |
| `0xFA` | Brightness Value |
| `0xFB` | Unused           |
| `0xFC` | Unused          |
| `0xFD` | Unused           |

```
```
Brightness command:

    CA 06 XX

Where:

-   `CA` = keyboard lighting command
-   `06` = brightness subcommand
-   `XX` = brightness value (00--FF)


Example:

``` bash
sudo brightness 255

