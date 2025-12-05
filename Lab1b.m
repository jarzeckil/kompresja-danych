% Imię i Nazwisko: Łukasz Jarzęcki
% Nr albumu:       331697

% Laboratorium PKD, 5 listopada 2025r, godz. 12:15 - 14:00.
% Kwantyzacja skalarna sygnałów: Kwantyzacja sygnału piłozębnego

close all
clear

% Generacja sygnału do kwantyzacji
N = 1024; % Liczba próbek sygnału
M = 3; % Liczba okresów sygnału
x = linspace(0, M*2*pi, N); % Wektor argumentu dla funkcji sawtooth
y = sawtooth(x) - 1; % Wektor próbek sygnału piłozębnego

subplot(211)
% Wykres sygnału kwantyzowanego
plot(y)
xlabel('Numer próbki');

% Kwantyzacja sygnału z użyciem funkcji round
quantLevels = 8; % Liczba poziomów kwantyzacji
quantLevels1 = quantLevels -1;
yQuantized = round(y * (quantLevels1 / 2)); % Kwantyzacja sygnału
yQuantized = yQuantized / (quantLevels1 / 2); % Przeskalowanie do oryginalnego zakresu

% Wykres sygnału skwantyzowanego
hold on;
plot(yQuantized, 'r--'); % Rysowanie skwantyzowanego sygnału
legend('Sygnał oryginalny', 'Sygnał skwantyzowany');
title('Kwantyzacja sygnału piłozębnego');
hold off;
grid on

subplot(212)
% Wykres błędu kwantyzacji
quantizationError = y - yQuantized; % Obliczanie błędu kwantyzacji
plot(quantizationError, 'm'); % Wykres błędu kwantyzacji
xlabel('Numer próbki');
title('Błąd kwantyzacji sygnału piłozębnego');
grid on;

% Obliczenie błędu średniokwadratowego dla sygnału skwantyzowanego
mse = mean(quantizationError.^2); % Obliczenie błędu średniokwadratowego
disp(['Błąd średniokwadratowy: ', num2str(mse)]);

% Obliczenie liczby bitów wymaganych do reprezentacji (zakodowania) danej liczby poziomów
% kwantyzacji
WymaganaLiczbaBitow = ceil(log2(quantLevels));
disp(['Wymagana liczba bitów: ', num2str(WymaganaLiczbaBitow)]);

% Obliczenie współczynnika kompresji przy założeniu, że oryginalne próbki
% sygnału zapisane są w formacie double precision, czyli 8 bajtów
% na próbkę.
originalSize = N * 8 * 8; % Rozmiar oryginalnego sygnału w bitach
quantizedSize = N * WymaganaLiczbaBitow; % Rozmiar skwantyzowanego sygnału w bitach
compressionRatio = originalSize / quantizedSize; % Współczynnik kompresji
disp(['Współczynnik kompresji: ', num2str(compressionRatio)]);

% Uwaga: Kodu powyżej nie modyfikujemy.

%###################################################
% Zadania do samodzielnego wykonania na laboratorium
%###################################################

% (1 pkt.)
% 1. W przykładowym kodzie zastąpić funkcję do kwantyzacji round() funkcją floor(),
% a następnie funkcją ceil() i porównać wyniki (wykresy i błąd średniokwadratowy).
% Czym się różnią te 3 funkcje? Dlaczego do kwantyzacji najkorzystniej stosować funkcję round()?
figure % Nowe okno rysowania
% ### Tu proszę dodać swój kod i komentarze: ###
subplot(211)
% Wykres sygnału kwantyzowanego
plot(y)
xlabel('Numer próbki');

quantLevels = 8; % Liczba poziomów kwantyzacji
quantLevels1 = quantLevels -1;

% Kwantyzacja sygnału z użyciem funkcji floor
yQuantized = floor(y * (quantLevels1 / 2)); % Kwantyzacja sygnału
yQuantized = yQuantized / (quantLevels1 / 2); % Przeskalowanie do oryginalnego zakresu

% Wykres sygnału skwantyzowanego
hold on;
plot(yQuantized, 'r--'); % Rysowanie skwantyzowanego sygnału
legend('Sygnał oryginalny', 'Sygnał skwantyzowany');
title('Kwantyzacja sygnału piłozębnego funkcją floor');
hold off;
grid on

quantizationError = y - yQuantized; % Obliczanie błędu kwantyzacji
mse = mean(quantizationError.^2); % Obliczenie błędu średniokwadratowego
disp(['Błąd średniokwadratowy dla kwantyzacji funkcją ceil: ', num2str(mse)]);

% Kwantyzacja sygnału z użyciem funkcji ceil
yQuantized = ceil(y * (quantLevels1 / 2)); % Kwantyzacja sygnału
yQuantized = yQuantized / (quantLevels1 / 2); % Przeskalowanie do oryginalnego zakresu

% Wykres sygnału skwantyzowanego
hold on;
plot(yQuantized, 'g--'); % Rysowanie skwantyzowanego sygnału
legend('Sygnał oryginalny', 'Sygnał skwantyzowany');
title('Kwantyzacja sygnału piłozębnego');
hold off;
grid on

quantizationError = y - yQuantized; % Obliczanie błędu kwantyzacji
mse = mean(quantizationError.^2); % Obliczenie błędu średniokwadratowego
disp(['Błąd średniokwadratowy dla kwantyzacji funkcją ceil: ', num2str(mse)]);



% (1 pkt.)
% 2. Dopisać do skryptu fragment kodu do obliczania i rysowania zależności
% wymaganej liczby bitów w funkcji liczby poziomów kwantyzacji, w zakresie
% od 2 do 128 poziomów kwantyzacji.
figure % Nowe okno rysowania
% ### Tu proszę dodać swój kod i komentarze: ###
quant_levels = linspace(2, 128, 127);
bit_count = ceil(log2(quant_levels));
plot(quant_levels, bit_count)
title('Zależność wymaganej liczby bitów od poziomów kwantyzacji');
xlabel('Liczba poziomów kwantyzacji');
ylabel('Wymagana liczba bitów')



% (1 pkt.)
% 3. Dopisać do skryptu fragment kodu do obliczania i rysowania zależności współczynnika
% kompresji w funkcji liczby poziomów kwantyzacji, w zakresie
% od 2 do 128 poziomów kwantyzacji.
figure % Nowe okno rysowania
% ### Tu proszę dodać swój kod i komentarze: ###
original_size = zeros(length(bit_count),1) + (N * 8 * 8);
original_size = reshape(original_size, [1, length(original_size)]);
quantized_size = N * bit_count; % Rozmiar skwantyzowanego sygnału w bitach
compression_ratio = original_size ./ quantized_size; % Współczynnik kompresji
plot(quant_levels, compression_ratio)
title('Zależność współczynnika kompresji od liczby poziomów kwantyzacji');
xlabel('Liczba poziomów kwantyzacji');
ylabel('współczynnik kompresji')


% (2 pkt.)
% 4. Dopisać do skryptu fragment kodu do kwantyzacji sygnału z wykorzystaniem funkcji quantizer() i quantize().
% Strony pomocy do funkcji:
% https://www.mathworks.com/help/fixedpoint/ref/embedded.quantizer.html
% https://www.mathworks.com/help/fixedpoint/ref/embedded.quantizer.quantize.html

% Tworzenie obiektu kwantyzera:
% q = quantizer('fixed','round','saturate',[wordlength fractionlength])
% Długość słowa liczymy na podstawie liczby poziomów kwantyzacji:
% wordlength = ceil(log2(quantLevels))
% Sprawdzenie zakresu kwantyzera:
% range(q)
% Kwantyzacja sygnału y za pomocą kwantyzera q:
% yq = quantize(q,y);
% Uwaga/Podpowiedź: trzeba najpierw odpowiednio przeskalować y do zakresu kwantyzera,
% a wynik kwantyzacji przeskalować z powrotem do pierwotnego zakresu
% sygnału. W wyniku powinniśmy otrzymać sygnał skwantyzowany taki sam,
% jak w przykładowym kodzie z wykorzystaniem funkcji round().
figure % Nowe okno rysowania
% ### Tu proszę dodać swój kod i komentarze: ###
wordlength = ceil(log2(quantLevels));
fractionlength = 0;
q = quantizer('fixed','round','saturate',[wordlength fractionlength]);

q_min = -4;
q_max = 3;

y_min = min(y);
y_max = max(y);

y_scaled = ((y-y_min) / (y_max - y_min)) * (q_max - q_min) + q_min;

yq = quantize(q, y_scaled);

yq_min = min(yq);
yq_max = max(yq);

yq_org = ((yq-yq_min) / (yq_max - yq_min)) * (y_max - y_min) + y_min;

subplot(211)
plot(y);
xlabel('Numer próbki');

hold on;
plot(yq_org, 'r--'); % Rysowanie skwantyzowanego sygnału
legend('Sygnał oryginalny', 'Sygnał skwantyzowany');
title('Kwantyzacja sygnału piłozębnego');
hold off;
grid on


% Uwaga: W sprawozdaniu proszę wykazać poprawność sposobu obliczania współczynnika
% kompresji.
