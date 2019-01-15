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
        ["Hi,","this","is"
        ,P.blue "Homespun"
        ,P.blue (P.text (Pkg.versionToString Compiler.version)) <> "."
        ]
    ]


outro :: P.Doc
outro =
  P.fillSep $ map P.text $ words $
    ""



