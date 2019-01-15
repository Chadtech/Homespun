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
import qualified Make

-- MAIN --


main :: IO ()
main = do  
    setLocaleEncoding utf8
    Args.complex intro outro
        [ make ]

-- MAKE --

make :: Interface
make =
    let
        details =
            "The `make` command compiles Elm code into JS or HTML:"

        example =
            stack
                [ reflow
                    "For example:"
                , P.indent 4 $ P.green "elm make src/Main.elm"
                , reflow
                    "This tries to compile an Elm file named src/Main.elm, putting the resulting\
                    \ JavaScript code in an elm.js file."
                ]

        makeFlags =
            flags Make.Flags
                |-- onOff "debug" "Turn on the time-travelling debugger. It allows you to rewind and replay events. The events can be imported/exported into a file, which makes for very precise bug reports!"
                |-- onOff "optimize" "Turn on optimizations to make code smaller and faster. For example, the compiler renames record fields to be as short as possible and unboxes values to reduce allocation."
                |-- flag "output" Output.output "Specify the name of the resulting JS file. For example --output=assets/elm.js to generate the JS at assets/elm.js or --output=/dev/null to generate no output at all!"
                |-- flag "report" Make.reportType "You can say --report=json to get error messages as JSON. This is only really useful if you are an editor plugin. Humans should avoid it!"
                |-- flag "docs" Make.docsFile "Generate a JSON file of documentation for a package. Eventually it will be possible to preview docs with `reactor` because it is quite hard to deal with these JSON files directly."
    in
    Interface
        "make"
        Uncommon
        details
        example
        (zeroOrMore elmFile)
        makeFlags
        Make.run


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
