<?php
$contents = file_get_contents("input.txt");
$lines = explode("\n", $contents);
$word = "XMAS";
$word_count_part_1 = 0;
$word_count_part_2 = 0;

function on_x_hit_part_1($x, $y, $lines, $word) {
    $word_length = strlen($word);
    $directions = [
        [1, 0],
        [0, 1],
        [1, 1],
        [1, -1],
        [-1, 0],
        [0, -1],
        [-1, -1],
        [-1, 1]
    ];
    $x_length = count($lines);
    $y_length = strlen($lines[0]);
    $word_count = 0;

    foreach ($directions as $direction) {
        $word_index = 0;
        $x_index = $x;
        $y_index = $y;

        while ($x_index >= 0 && $x_index < $x_length && $y_index >= 0 && $y_index < $y_length) {
            if ($lines[$x_index][$y_index] == $word[$word_index]) {
                $word_index++;
                if ($word_index == $word_length) {
                    $word_count++;
                    break;
                }
            } else {
                break;
            }
            $x_index += $direction[0];
            $y_index += $direction[1];
        }
    }

    return $word_count;
}

for ($i = 0; $i < count($lines); $i++) {
    for ($j = 0; $j < strlen($lines[$i]); $j++) {
        if ($lines[$i][$j] == "X") {
            $word_count_part_1 += on_x_hit_part_1($i, $j, $lines, $word);
        }
    }
}

function on_a_hit_part_2($x, $y, $lines) {
    $x_length = count($lines);
    $y_length = strlen($lines[0]);
    $word_count = 0;

    if ($x > 0 && $y > 0 && $x < $x_length - 1 && $y < $y_length - 1) {
        if ($lines[$x - 1][$y - 1] == "M" && $lines[$x + 1][$y + 1] == "S") {
            $word_count++;
        }
        if ($lines[$x - 1][$y + 1] == "M" && $lines[$x + 1][$y - 1] == "S") {
            $word_count++;
        }
        if ($lines[$x - 1][$y - 1] == "S" && $lines[$x + 1][$y + 1] == "M") {
            $word_count++;
        }
        if ($lines[$x - 1][$y + 1] == "S" && $lines[$x + 1][$y - 1] == "M") {
            $word_count++;
        }
    }

    if ($word_count == 2) {
        return 1;
    };

    return 0;
}

for ($i = 0; $i < count($lines); $i++) {
    for ($j = 0; $j < strlen($lines[$i]); $j++) {
        if ($lines[$i][$j] == "A") {
            $word_count_part_2 += on_a_hit_part_2($i, $j, $lines);
        }
    }
}

echo "Part 1: $word_count_part_1\n";
echo "Part 2: $word_count_part_2\n";
?>