import Data.List
import System.Environment
import System.IO

type FileContent = String
type FileName = String

main :: IO ()
main = do
  args <- getArgs
  cs <- mapM readFile args
  putStrLn $ paste cs

extend :: [[String]] -> [[String]]
extend fileLines = fmap appendEmpty fileLines
  where max = maximum (fmap length fileLines)
        appendEmpty l = l ++ replicate (max - length l) ""

paste :: [FileContent] -> String
paste cs = unlines $ (fmap (intercalate "\t") . transpose) fileLines
  where fileLines = extend (lines <$> cs)
