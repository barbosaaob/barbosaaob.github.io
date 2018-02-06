function start_game() {
    min_range = 1;
    max_range = 100;

    target = min_range + Math.random() * (max_range - min_range);
    target = Math.trunc(target);

	console.log(target);

    var guesses = 0;
    var game_over = false;
    while (!game_over) {
        guess = prompt("Escolha um número entre " +
                    min_range + " e " + max_range);
        if (!guess) {
            alert("Você desistiu.\nFim de jogo.");
            return false;
        }
        guess = parseInt(guess);
        guesses++;
        game_over = check_guess(guess);

    }
    alert("Bom trabalho! O número secreto é " + target + "." +
            "\nVocê completou com " + guesses + " chutes.")
}

function check_guess(guess) {
    if (isNaN(guess)) {
        alert("Por favor, escolha um número.");
        return false;
    }
    if ( (guess < min_range) || (guess > max_range) ) {
        alert("Por favor, escolha um número entre " +
                min_range + " e " + max_range);
        return false;
    }
    if (guess < target) {
        alert("Escolha um número maior.");
        return false;
    }
    if (guess > target) {
        alert("Escolha um número menor.");
        return false;
    }
    return true;
}
