module Main ( main ) where

import Data.Char
import Data.List
import Data.Maybe
import System.Environment
import System.Exit

data Direction = Unknown | Increasing | Decreasing
    deriving (Eq, Show)

scanReports :: [Int] -> Bool
scanReports levels =
    let doScan :: Direction -> [Int] -> Bool
        doScan _ [x] = True
        doScan dir (x:y:zs) =
            if (x == y) || (abs (x - y)) > 3
                then False
                else case dir of
                        Unknown ->
                            if y < x
                                then doScan Decreasing (y:zs)
                                else doScan Increasing (y:zs)
                        Increasing ->
                            if y < x
                                then False
                                else doScan dir (y:zs)
                        Decreasing ->
                            if y > x
                                then False
                                else doScan dir (y:zs)
    in doScan Unknown levels

scanReportsWithRetries :: [Int] -> Bool
scanReportsWithRetries levels =
    if scanReports levels
        then True
        else let levelsCount = length levels
                 retries = filter (\x -> (length x) == (levelsCount - 1)) (subsequences levels)
             in any (\x -> x == True) $ map scanReports retries

process :: String -> Int
process contents = length $ elemIndices True $ map scanReportsWithRetries $ map (map read) $ map words $ lines contents

main :: IO ()
main = do

      contents <- readFile "input.txt"
      let result = process contents
      putStrLn $ "day 2 result - " ++ show result