// V script for calculating randomness accuracy using PRNG randomness "rand.rand()" vs machine randomnesss crypto.rand()

module main

import rand
import math
// import crypto.rand as rand_machine

fn main() {
	loops := 1_000_000_000
	mut zeros_win := 0
	mut ones_win := 0
	mut numbers := [][]u64{}

	mut i := 0
	for i < loops {
		numbers = get_rand_zeros_ones_array(1, 'prng'.to_upper())!
		if numbers[0].len > numbers[1].len {
			zeros_win++
		}
		if numbers[0].len < numbers[1].len {
			ones_win++
		}
		i++
		// println(numbers)
	}
	println('Ran the random generator ${i} times')

	mut accuracy := 0.0000

	if zeros_win > ones_win { // if MORE zeros than ones
		perfect := (zeros_win + ones_win) / 2
		difference := zeros_win - ones_win

		accuracy = calculate_accuracy(perfect, zeros_win)

		println('\nWinner is ${zeros_win} ZEROS against ${ones_win} ones with a difference by ${difference}')
		println('The perfect result would be ${perfect} zeros / ${loops} numbers')
		println('Accuracy: ${accuracy} percent(%)')
	} else if zeros_win < ones_win { // if LESS zeros than ones
		perfect := (ones_win + zeros_win) / 2
		difference := ones_win - zeros_win

		accuracy = calculate_accuracy(perfect, ones_win)

		println('\nWinner is ${ones_win} ONES against ${zeros_win} zeros with a difference by ${difference}')
		println('The perfect result would be ${perfect} ones / ${loops} numbers')
		println('Accuracy: ${accuracy} percent(%)')
	} else {
		println('Congratulation!! You won the random accuracy lottery. Result was 100% PERFECT')
	}
}

fn calculate_accuracy(a f64, b f64) f64 {
	accuracy := (1.0 - (math.abs(a - b) / a)) * 100.0 // Formula for accuracy in percent %
	return accuracy
}

pub fn get_rand_zeros_ones_array(count int, mode string) ![][]u64 {
	mut zeros := []u64{}
	mut ones := []u64{}
	mut numbers := [][]u64{}
	mut r := u64(0)

	for _ in 0 .. count {
		if mode == 'PRNG' {
			r = rand.u64_in_range(0, 2)!
		} else {
			println('Work in progress to get real random zeros and ones not PRNGs for comparison')
		}

		// println(r)
		match r {
			0 { zeros << r }
			1 { ones << r }
			else { println('Not 0 or 1') }
		}
	}
	numbers << zeros
	numbers << ones

	return numbers
}

fn generate_random_bits(length int) []int {
	mut bits := []int{len: length}
	for i in 0 .. length {
		// Generate a random byte
		random_byte := rand.u8()
		// Use bitwise AND to get either 0 or 1
		bits[i] = int(random_byte & 1)
	}
	return bits
}
