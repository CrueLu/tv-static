module Picture.RandomStatic
    ( makeRandomStatic
    , Width, Height
    )
where
import Codec.Picture   (generateImage, Image, PixelRGB8)
import Data.List.Extra (chunksOf, genericTake)
import Numeric.Natural (Natural)
import System.Random   (newStdGen, randomRs)

type Width  = Natural
type Height = Natural

makeRandomStatic :: Width -> Height -> [PixelRGB8] -> IO (Image PixelRGB8)
makeRandomStatic w h cs
    | length cs < 2 = error "need at least two colours"
    | otherwise = do
        randomGrid <- chunksOf (fromIntegral w) . genericTake (w * h) . randomRs (0, length cs - 1) <$> newStdGen
        pure $ generateImage (\x y -> cs !! (randomGrid !! y !! x)) (fromIntegral w) (fromIntegral h)