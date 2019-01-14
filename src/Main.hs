{-# LANGUAGE OverloadedStrings #-}
module Main
  ( main
  )
  where


import Prelude hiding (init)
import GHC.IO.Encoding (setLocaleEncoding, utf8)
import qualified Text.PrettyPrint.ANSI.Leijen as P
import Text.PrettyPrint.ANSI.Leijen ((<>))

import qualified Homespun.Compiler as Compiler
import qualified Homespun.Package as Pkg
import qualified Terminal.Args as Args


-- MAIN


main :: IO ()
main = do  
    setLocaleEncoding utf8
    Args.complex intro outro
        []


intro :: P.Doc
intro =
  P.vcat
    [ P.fillSep
        ["Hi,","thank","you","for","trying","out"
        ,P.green "Elm"
        ,P.green (P.text (Pkg.versionToString Compiler.version)) <> "."
        ,"I hope you like it!"
        ]
    , ""
    , P.black "-------------------------------------------------------------------------------"
    , P.black "I highly recommend working through <https://guide.elm-lang.org> to get started."
    , P.black "It teaches many important concepts, including how to use `elm` in the terminal."
    , P.black "-------------------------------------------------------------------------------"
    ]


outro :: P.Doc
outro =
  P.fillSep $ map P.text $ words $
    "Be sure to ask on the Elm slack if you run into trouble! Folks are friendly and\
    \ happy to help out. They hang out there because it is fun, so be kind to get the\
    \ best results!"



