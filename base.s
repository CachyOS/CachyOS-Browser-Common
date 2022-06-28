patches/gentoo/0039-bmo-1774075-vaapi-fixes-p2-p3-D149238.patch:+    if (!surface || !surface->CreateTexture(desc.gl)) {
patches/gentoo/0039-bmo-1774075-vaapi-fixes-p2-p3-D149238.patch:+    const auto tex = surface->GetTexture();
patches/gentoo/0040-bmo-1774271-vaapi-fixes-p2-p5.patch:+      name = BLOCKLIST_PREF_BRANCH "dmabuf.surface-export";
patches/gentoo/0035-bmo-1735929-webgl-nvidia-p3-D147637.patch:-  if (!surface || !surface->CreateTexture(desc.gl)) {
patches/gentoo/0035-bmo-1735929-webgl-nvidia-p3-D147637.patch:-  const auto tex = surface->GetTexture();
patches/gentoo/0035-bmo-1735929-webgl-nvidia-p3-D147637.patch:+  if (!importedSurface->CreateTexture(&gl)) {
