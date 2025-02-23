{   
  stdenv
, fetchFromGitHub
, fetchurl
, cmake
, dbus
, file
, freetype
, jansson
, lib
, libXext
, libXrandr
, libarchive
, libjack2
, liblo
, libsamplerate
, mesa
, libsndfile
, makeWrapper
, pkg-config
, python3
, speexdsp
, libglvnd
}:

stdenv.mkDerivation rec {
  pname = "cardinal";
  version = "22.11";
  version = "22.12";

  src = fetchurl {
    url =
      "https://github.com/DISTRHO/Cardinal/releases/download/${version}/cardinal+deps-${version}.tar.xz";
    sha256 = "sha256-xYQi209whY5/lN+6Fp7PTp7JSzL6RS6VL+Exst7RrS0=";
    sha256 = "sha256-fyko5cWjBNNaw8qL9uyyRxW5MFXKmOsBoR5u05AWxWY=";
  };

  prePatch = ''
    patchShebangs ./dpf/utils/generate-ttl.sh
  '';

  dontUseCmakeConfigure = true;
  enableParallelBuilding = true;
  strictDeps = true;

  nativeBuildInputs = [ pkg-config ];
  nativeBuildInputs = [
    cmake
    file
    pkg-config
    makeWrapper
    python3
  ];
  buildInputs = [
    dbus
    freetype
    jansson
    libGL
    libX11
    libXcursor
    libXext
    libXrandr
    libXrandr
    libarchive
    liblo
    libsamplerate
    mesa
    python3
    libsndfile
    speexdsp
    libglvnd
  ];

  hardeningDisable = [ "format" ];
  makeFlags = [ "SYSDEPS=true" "PREFIX=$(out)" ];

  postInstall = ''
    wrapProgram $out/bin/Cardinal \
    --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ libjack2 ]}
    # this doesn't work and is mainly just a test tool for the developers anyway.
    rm -f $out/bin/CardinalNative
  '';

  meta = {
    description = "Plugin wrapper around VCV Rack";
    homepage = "https://github.com/DISTRHO/cardinal";
    license = lib.licenses.gpl3;
    maintainers = [ lib.maintainers.magnetophon ];
    platforms = lib.platforms.all;
    # never built on aarch64-darwin, x86_64-darwin since first introduction in nixpkgs
    broken = stdenv.isDarwin;
  };
}