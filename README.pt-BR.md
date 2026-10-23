# dotnetup e global.json: qual SDK o dotnet escolhe?

Artigo completo: <https://ceseidl.com.br/artigos/dotnetup-sdks-runtimes/>

[English](README.md) | Português

> **Início rápido**

```bash
bash scripts/run-cases.sh
```

Código do artigo *dotnetup: Gerenciando SDKs e Runtimes do .NET sem Administrador*. O [dotnetup](https://devblogs.microsoft.com/dotnet/introducing-dotnetup/) é o novo gerenciador de toolchain do .NET (public preview) e respeita o `global.json` de cada repositório. Este repositório mostra, com o `dotnet` que você já tem, o que esse arquivo decide: três pastas, um `global.json` em cada, e `dotnet --version` executado dentro de cada uma. Ele **não** instala nem executa o dotnetup.

## Casos

| Pasta | `version` | `rollForward` | Esperado |
|---|---|---|---|
| `cases/1-pin-exact` | 8.0.426 | `disable` | roda exatamente a 8.0.426 |
| `cases/2-roll-feature` | 10.0.100 | `latestFeature` | roda a feature band 10.0 mais nova instalada |
| `cases/3-missing-sdk` | 9.0.100 | `disable` | falha: nenhum SDK compatível |

## Requisitos

- Bash (o Git Bash no Windows serve) ou PowerShell 7
- Os SDKs 8.0.426 e 10.0.402 instalados, para obter a saída abaixo. Com outros SDKs, os dois primeiros casos mudam de acordo.

## Como rodar

```bash
bash scripts/run-cases.sh
```

```powershell
pwsh scripts/run-cases.ps1
```

## Saída esperada

Em uma máquina com os SDKs 8.0.426 e 10.0.402 (sem SDK 9):

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

No PowerShell do Windows o último código de saída é 0x8000809B (-2147450725); o bash mostra só o byte baixo, 155.

## Estrutura

```
cases/
├── 1-pin-exact/global.json
├── 2-roll-feature/global.json
└── 3-missing-sdk/global.json
scripts/
├── run-cases.sh
└── run-cases.ps1
```

## Notas

- Não há `global.json` na raiz de propósito, para não interferir nos casos.
- O mapeamento de `rollForward` para canais do dotnetup (por exemplo `latestFeature` para `10.0`) vem da documentação do Microsoft Learn e não é exercitado aqui.

## Licença

MIT
