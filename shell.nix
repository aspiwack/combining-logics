with { pkgs = import ./nix {}; };
pkgs.mkShell
  { buildInputs = with pkgs; [
      niv
      # haskellPackages.lhs2tex
      biber
      ott
      pdftk
      entr
      (texlive.combine {
        inherit (texlive)
          # basic toolbox
          scheme-small
          cleveref
          latexmk
          biblatex biblatex-software
          stmaryrd
          unicode-math lm lm-math
          logreq xstring
          xargs todonotes
          mathpartir
          newunicodechar
          bussproofs

          # for ott
          supertabular

          # html conversion
          lwarp
          ifptex xpatch catchfile comment environ trimspaces varwidth
          everyhook svn-prov xifthen printlen capt-of framed moreverb
          ;
      })

      ];
}
