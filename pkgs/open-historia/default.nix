{
 lib,
 buildNpmPackage,
 fetchFromGitHub,
 fetchurl,
 nodejs_22,
 makeWrapper,
}:

let
 ## MAP DATA
 releaseUrl = "https://github.com/Open-Historia/open-historia/releases/download/map-data";

 mapAssets = map (a: a // {
   file = fetchurl {
     url = "${releaseUrl}/${a.name}";
     hash = a.hash;
   };
 }) [
   { name = "regions.pmtiles";         dest = "public/assets/regions.pmtiles";         hash = lib.fakeHash; }
   { name = "countries.pmtiles";       dest = "public/assets/countries.pmtiles";       hash = lib.fakeHash; }
   { name = "cities.pmtiles";          dest = "public/assets/cities.pmtiles";          hash = lib.fakeHash; }
   { name = "regions-seed.geojson";    dest = "public/assets/regions-seed.geojson";    hash = lib.fakeHash; }
   { name = "cities-seed.json";        dest = "public/assets/cities-seed.json";        hash = lib.fakeHash; }
   { name = "default-regions.geojson"; dest = "server/seed/default/regions.geojson";   hash = lib.fakeHash; }
 ];
in
buildNpmPackage {
 ## INFO
 pname = "open-historia";
 version = "0-unstable-2026-11-02";

 ## SOURCE
 src = fetchFromGitHub {
   owner = "Open-Historia";
   repo = "open-historia";
   rev = "PIN_A_COMMIT";
   hash = lib.fakeHash;
 };

 ## NODE
 nodejs = nodejs_22;
 npmDepsHash = lib.fakeHash;
 npmFlags = [ "--omit=optional" ];
 env.ELECTRON_SKIP_BINARY_DOWNLOAD = "1";

 nativeBuildInputs = [ makeWrapper ];

 ## MAP DATA INSTALL
 postPatch = lib.concatMapStrings (a: ''
   install -Dm644 ${a.file} ${a.dest}
 '') mapAssets;

 ## INSTALL
 installPhase = ''
   runHook preInstall
   mkdir -p $out/lib/open-historia $out/bin
   cp -r . $out/lib/open-historia
   makeWrapper ${lib.getExe nodejs_22} $out/bin/open-historia \
     --add-flags $out/lib/open-historia/server/server.js
   runHook postInstall
 '';

 ## METADATA
 meta = {
   description = "Open source alternative to Pax Historia";
   homepage = "https://github.com/Open-Historia/open-historia";
   license = lib.licenses.agpl3Plus;
   mainProgram = "open-historia";
 };
}
