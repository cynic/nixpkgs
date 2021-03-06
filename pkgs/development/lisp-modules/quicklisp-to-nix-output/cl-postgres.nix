args @ { fetchurl, ... }:
rec {
  baseName = ''cl-postgres'';
  version = ''postmodern-20170403-git'';

  description = ''Low-level client library for PostgreSQL'';

  deps = [ args."md5" ];

  src = fetchurl {
    url = ''http://beta.quicklisp.org/archive/postmodern/2017-04-03/postmodern-20170403-git.tgz'';
    sha256 = ''1pklmp0y0falrmbxll79drrcrlgslasavdym5r45m8kkzi1zpv9p'';
  };

  overrides = x: {
    postInstall = ''
      find "$out/lib/common-lisp/" -name '*.asd' | grep -iv '/cl-postgres[.]asd${"$"}' |
        while read f; do
          env -i \
          NIX_LISP="$NIX_LISP" \
          NIX_LISP_PRELAUNCH_HOOK="nix_lisp_run_single_form '(progn
            (asdf:load-system :$(basename "$f" .asd))
            (asdf:perform (quote asdf:compile-bundle-op) :$(basename "$f" .asd))
            (ignore-errors (asdf:perform (quote asdf:deliver-asd-op) :$(basename "$f" .asd)))
            )'" \
            "$out"/bin/*-lisp-launcher.sh ||
          mv "$f"{,.sibling}; done || true
    '';
  };
}
/* (SYSTEM cl-postgres DESCRIPTION Low-level client library for PostgreSQL SHA256 1pklmp0y0falrmbxll79drrcrlgslasavdym5r45m8kkzi1zpv9p URL
    http://beta.quicklisp.org/archive/postmodern/2017-04-03/postmodern-20170403-git.tgz MD5 7a4145a0a5ff5bcb7a4bf29b5c2915d2 NAME cl-postgres TESTNAME NIL
    FILENAME cl-postgres DEPS ((NAME md5)) DEPENDENCIES (md5) VERSION postmodern-20170403-git SIBLINGS (postmodern s-sql simple-date)) */
