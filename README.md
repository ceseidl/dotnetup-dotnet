# dotnetup and global.json: which SDK does dotnet pick?

English | [Português](README.pt-BR.md)

> **Quick start**

```bash
bash scripts/run-cases.sh
```

Companion code for the article *dotnetup: Gerenciando SDKs e Runtimes do .NET sem Administrador*. [dotnetup](https://devblogs.microsoft.com/dotnet/introducing-dotnetup/) is the new .NET toolchain manager (public preview) and it respects the `global.json` of each repository. This repo shows, with the `dotnet` you already have, what that file decides: three folders, one `global.json` each, and `dotnet --version` run inside each of them. It does **not** install or run dotnetup.

## Cases

| Folder | `version` | `rollForward` | Expected |
|---|---|---|---|
| `cases/1-pin-exact` | 8.0.426 | `disable` | runs exactly 8.0.426 |
| `cases/2-roll-feature` | 10.0.100 | `latestFeature` | runs the newest 10.0 feature band installed |
| `cases/3-missing-sdk` | 9.0.100 | `disable` | fails: no compatible SDK |

## Requirements

- Bash (Git Bash on Windows works) or PowerShell 7
- The .NET SDKs 8.0.426 and 10.0.402 installed, to get the output below. With other SDKs the first two cases change accordingly.

## Run

```bash
bash scripts/run-cases.sh
```

```powershell
pwsh scripts/run-cases.ps1
```

## Expected output

On a machine with SDKs 8.0.426 and 10.0.402 (no SDK 9):

```
[1-pin-exact] version=8.0.426 rollForward=disable
  exit=0
  8.0.426
[2-roll-feature] version=10.0.100 rollForward=latestFeature
  exit=0
  10.0.402
[3-missing-sdk] version=9.0.100 rollForward=disable
  exit=155
  A compatible .NET SDK was not found.
```

On Windows PowerShell the last exit code is 0x8000809B (-2147450725); bash shows only its low byte, 155.

## Structure

```
cases/
├── 1-pin-exact/global.json
├── 2-roll-feature/global.json
└── 3-missing-sdk/global.json
scripts/
├── run-cases.sh
└── run-cases.ps1
```

## Notes

- There is deliberately no `global.json` at the repository root, so it does not interfere with the cases.
- The mapping from `rollForward` to dotnetup channels (for example `latestFeature` to `10.0`) comes from the Microsoft Learn documentation and is not exercised here.

## License

MIT
