-- -*-haskell-*-
--  GIMP Toolkit (GTK) Widget Arrow
--
--  Author : Axel Simon
--
--  Created: 23 May 2001
--
--  Version $Revision: 1.1 $ from $Date: 2005/02/26 02:17:27 $
--
--  Copyright (C) 1999-2005 Axel Simon
--
--  This library is free software; you can redistribute it and/or
--  modify it under the terms of the GNU Lesser General Public
--  License as published by the Free Software Foundation; either
--  version 2.1 of the License, or (at your option) any later version.
--
--  This library is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--  Lesser General Public License for more details.
--
-- |
-- Maintainer  : gtk2hs-users@lists.sourceforge.net
-- Stability   : provisional
-- Portability : portable (depends on GHC)
--
-- An Arrow pointing in one of the four cardinal directions.
--
module Graphics.UI.Gtk.Misc.Arrow (
-- * Description
-- 
-- | 'Arrow' should be used to draw simple arrows that need to point in one of
-- the four cardinal directions (up, down, left, or right). The style of the
-- arrow can be one of shadow in, shadow out, etched in, or etched out. Note
-- that these directions and style types may be ammended in versions of Gtk to
-- come.
--
-- 'Arrow' will fill any space alloted to it, but since it is inherited from
-- 'Misc', it can be padded and\/or aligned, to fill exactly the space the
-- programmer desires.
--
-- Arrows are created with a call to 'arrowNew'. The direction or style of
-- an arrow can be changed after creation by using 'arrowSet'.

-- * Class Hierarchy
-- |
-- @
-- |  'GObject'
-- |   +----'Object'
-- |         +----'Widget'
-- |               +----'Misc'
-- |                     +----Arrow
-- @

-- * Types
  Arrow,
  ArrowClass,
  castToArrow,
  ArrowType(..),
  ShadowType(..),

-- * Constructors
  arrowNew,

-- * Methods
  arrowSet
  ) where

import Monad	(liftM)

import System.Glib.FFI
import Graphics.UI.Gtk.Abstract.Object	(makeNewObject)
{#import Graphics.UI.Gtk.Types#}
{#import Graphics.UI.Gtk.Signals#}
import Graphics.UI.Gtk.General.Enums	(ArrowType(..), ShadowType(..))

{# context lib="gtk" prefix="gtk" #}

--------------------
-- Constructors

-- | Creates a new arrow with display options.
--
arrowNew :: 
    ArrowType
 -> ShadowType
 -> IO Arrow
arrowNew arrowType shadowType =
  makeNewObject mkArrow $ liftM castPtr $ 
  {# call unsafe arrow_new #}
    ((fromIntegral . fromEnum) arrowType)
    ((fromIntegral . fromEnum) shadowType)

--------------------
-- Methods

-- | Sets the direction and style of the 'Arrow'.
--
arrowSet :: ArrowClass self => self
 -> ArrowType
 -> ShadowType
 -> IO ()
arrowSet self arrowType shadowType =
  {# call arrow_set #}
    (toArrow self)
    ((fromIntegral . fromEnum) arrowType)
    ((fromIntegral . fromEnum) shadowType)
