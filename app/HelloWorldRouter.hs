{-# LANGUAGE OverloadedStrings #-}

-- Hello World server

module Main where

import Control.Concurrent
import Control.Monad
import System.ZMQ4.Monadic
import Text.Printf
import Data.ByteString.Char8 (unpack)

main :: IO ()
main = runZMQ $ do
    -- Socket to talk to clients
    responder <- socket Router
    bind responder "tcp://*:5555"

    forever $ do
        buffer <- receive responder
        liftIO $ do 
        	printf "received request: %s\n" . unpack $ buffer
        	threadDelay 1000000 -- Do some 'work'
        send responder [] "World"