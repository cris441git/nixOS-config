{
 stdenv,
 autoPatchelfHook,
 audacious-bare,
 curl,
}:

stdenv.mkDerivation {
 ## INFO
 pname = "audacious-discord-rpc";
 version = "prebuilt";

 ## SOURCE
 src = ./discord-rpc.so;
 dontUnpack = true;

 ## BUILD INPUTS
 nativeBuildInputs = [ autoPatchelfHook ];

 buildInputs = [
   audacious-bare
   curl
   stdenv.cc.cc.lib
 ];

 ## INSTALL
 installPhase = ''
   install -Dm755 $src $out/lib/audacious/General/discord-rpc.so
 '';
}
