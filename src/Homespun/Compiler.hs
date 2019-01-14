{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE OverloadedStrings #-}


module Homespun.Compiler
    (version
    )
    where



import qualified Homespun.Package as Pkg


version :: Pkg.Version
version =
    Pkg.Version 0 0 0