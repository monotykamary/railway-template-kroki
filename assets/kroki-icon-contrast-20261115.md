# Kroki icon contrast adaptation

Source: the official Kroki logo at https://raw.githubusercontent.com/yuzutech/kroki/2e67edde965c155ecfdad446efb5fe7db8e3ed66/server/src/main/resources/web/root/assets/logo.svg (tag v0.36.0).

Copyright (c) 2020-present Kroki. MIT; the complete upstream license is included as `kroki-icon-source-LICENSE.txt`.

The pinned upstream repository's brand-asset search found only the dark `#363636` Kroki wordmark; its other colored/light logos belong to embedded diagrams.net integrations and unrelated brands, not Kroki. No suitable official colored/light Kroki variant was found there.

This adaptation retains the entire first K subpath and its original fill, without clipping the lower stroke, distortion, or recoloring. It is proportionally rendered at 342×416 pixels, bounds `(85,48)-(427,464)`, on a rounded `#f5f7fb` contrast backplate. The backplate is a documented dark-theme contrast adaptation, not padding added to enlarge a small logo. Transparent outer margins remain. The mark/backplate contrast ratio is 11.27:1; it is identifiable on both Railway dark and light backgrounds.

Output: `kroki-icon-contrast-20261115.png`, 512×512 RGBA, 23,592 bytes. Alpha extrema 0–255; alpha bounds `(16,16)-(497,497)` (481×481). SHA-256: `7178d431bd744ff7fb3cf2600b71b245c3ec3d47cf91d6585ad72875669d18fd`.

The isolated source render had transparent margin on all sides, proving the K path was not clipped. Rasterization, alpha/bounds/contrast validation and dark/light previews ran on boat. This asset-only commit does not replace or change the independently validated runtime source commit.
