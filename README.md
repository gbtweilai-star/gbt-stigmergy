# stigmergy

**One capability bit from GBT V8, packaged standalone.** No. 6 of 341,
`collab` domain (Collab).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> **协作层的间接通道**：Stigmergy（共识主动性 / 信息素场地）。四原语 DEPOSIT/READ/DECAY/FORAGE；只有 DEPOSIT 会写、且**只追加**（挥发是读数，账本可回放）。五条红线做成机械闸：**无源不许留** deposit_without_source · **种类白名单** deposit_kind_not_allowed · **只追加** pheromone_deleted_or_overwritten（静态核本模块源码）· **不留明文密钥** plaintext_key_in_pheromone · **只给读数**（FORAGE 只排序不执行）。与 collab_gateway **并排、不替代**：直连=会话/对等方/收件箱，间接=信息素场地；场地放在 store/collab/stigmergy/。type=internal

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-stigmergy.git
cd gbt-stigmergy
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_stigmergy info                  # capability card
python -m gbt_stigmergy spec --json           # machine-readable contract
python -m gbt_stigmergy check --payload '{}'
python -m gbt_stigmergy run   --payload '{}'
```

Real `info` output from this machine:

```text
stigmergy  (collab)  v1.0.0
----------------------------------------
**协作层的间接通道**：Stigmergy（共识主动性 / 信息素场地）。四原语 DEPOSIT/READ/DECAY/FORAGE；只有 DEPOSIT 会写、且**只追加**（挥发是读数，账本可回放）。五条红线做成机械闸：**无源不许留** deposit_without_source · **种类白名单** deposit_kind_not_allowed · **只追加** pheromone_deleted_or_overwritten（静态核本模块源码）· **不留明文密钥** plaintext_key_in_pheromone · **只给读数**（FORAGE 只排序不执行）。与 collab_gateway **并排、不替代**：直连=会话/对等方/收件箱，间接=信息素场地；场地放在 store/collab/stigmergy/。type=internal

gated      : False
external   : False
multi-op   : True
params     : (none)
values     : store, collab, stigmergy
```

Wire a real implementation:

```python
from gbt_stigmergy import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（3 个）**：`store`、`collab`、`stigmergy`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.17s
```

## Provenance

| field | value |
|---|---|
| capability | `stigmergy` |
| domain | `collab` |
| handler | `stigmergy` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [collab/stigmergy](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/collab/stigmergy.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
