module Homespun.Package
    ( Version(..)
    , versionToString
    )
    where


import Data.Monoid ((<>))
import qualified Data.Text as Text
import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.Builder as TLB
import qualified Data.Text.Lazy.Builder.Int as B TLBI
import Data.Word (Word16)


-- PACKAGE VERSIONS --


data Version =
    Version
        { _major :: {-# UNPACK #-} !Word16
        , _minor :: {-# UNPACK #-} !Word16
        , _patch :: {-# UNPACK #-} !Word16
        }
        deriving (Eq, Ord)


versionToString :: Version -> String
versionToString version =
    Text.unpack (versionToText version)


versionToText :: Version -> Text
versionToText (Version major minor patch) =
    TL.toStrict $ TLB.toLazyText $
    TLBI.decimal major
        <> TLB.singleton '.'
        <> TLBI.decimal minor
        <> TLB.singleton '.'
        <> TLBI.decimal patch