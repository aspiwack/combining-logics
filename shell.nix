with { pkgs = import ./nix {}; };

let
  # See https://stackoverflow.com/a/53572564
  ignoringVulns = x: x // { meta = (x.meta // { knownVulnerabilities = []; }); };
  xpdf-novulns = pkgs.xpdf.overrideAttrs ignoringVulns;
in


pkgs.mkShell
  { buildInputs = with pkgs; [
      # niv
      # haskellPackages.lhs2tex
      biber
      ott
      pdftk xpdf-novulns
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
