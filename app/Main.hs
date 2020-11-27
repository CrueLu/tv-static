{-# LANGUAGE LambdaCase #-}

module Main where

import Codec.Picture (DynamicImage (ImageRGB8), PixelRGB8 (..), savePngImage)
import Data.Char (isDigit, toLower)
import Picture.RandomStatic (Height, Width, makeRandomStatic)
import System.Environment (getArgs)
import System.IO (hFlush, stdout)

main :: IO ()
main = do
    (w, h) <- getDimensions
    cs <- ([PixelRGB8 255 255 255, PixelRGB8 0 0 0] ++) <$> getColours
    img <- makeRandomStatic w h cs
    savePngImage "./tvstatic.png" (ImageRGB8 img)
    putStrLn "Saved as 'tvstatic.png'"

getColours :: IO [PixelRGB8]
getColours = do
    putStr "Add another colour? (y/N): " >> flush
    l <- getLine
    if null l || toLower (head l) == 'n'
        then pure []
        else do
            putStr "Red:   " >> flush
            r <- getNumberLimited 255
            putStr "Green: " >> flush
            g <- getNumberLimited 255
            putStr "Blue:  " >> flush
            b <- getNumberLimited 255
            (PixelRGB8 r g b :) <$> getColours

getDimensions :: IO (Width, Height)
getDimensions =
    getArgs >>= \case
        (x : y : _) ->
            if all isDigit (x ++ y)
                then pure (read x, read y)
                else do
                    putStrLn "Invalid arguments."
                    putStr "Width:  " >> flush
                    width <- getNumber
                    putStr "Height: " >> flush
                    height <- getNumber
                    pure (width, height)
        _ -> do
            putStr "Width:  " >> flush
            width <- getNumber
            putStr "Height: " >> flush
            height <- getNumber
            pure (width, height)

getNumber :: (Integral a, Read a) => IO a
getNumber = do
    n <- getLine
    if all isDigit n
        then pure (read n)
        else do
            putStrLn "Invalid natural number."
            getNumber

getNumberLimited :: (Integral a, Read a, Show a) => a -> IO a
getNumberLimited sup = do
    n <- getNumber
    if n > sup
        then do
            putStrLn $ "Number must be below " ++ show sup ++ "."
            getNumberLimited sup
        else pure n

flush :: IO ()
flush = hFlush stdout