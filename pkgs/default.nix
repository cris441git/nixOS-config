final: prev: {
 ## GAMES
 open-historia = final.callPackage ./open-historia { };

 ## AUDACIOUS PLUGINS
 audacious-discord-rpc = final.callPackage ./audacious-discord-rpc { };

 audacious-plugins = prev.audacious-plugins.overrideAttrs (old: {
   postInstall = (old.postInstall or "") + ''
     install -Dm755 ${final.audacious-discord-rpc}/lib/audacious/General/discord-rpc.so \
       $out/lib/audacious/General/discord-rpc.so
   '';
 });
}
