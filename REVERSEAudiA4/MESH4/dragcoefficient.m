clear all, close all, clc

%% Convergenza Cd vs iterazioni

% Specifica il percorso al file forceCoeff.dat
filePath = 'postProcessing/forceCoeffs1/0/coefficient.dat';

% Leggi il file ignorando le righe di commento
data = readmatrix(filePath, 'FileType', 'text', 'CommentStyle', '#');

% Estrai le colonne dal file
% Assumiamo che la prima colonna sia il tempo/iterazioni e la seconda C_d
iterations = data(:, 1); % Colonna 1: Iterazioni o tempo
Cd = data(:, 2);         % Colonna 2: Coefficiente di resistenza C_d

% Plotta C_d vs Iterazioni
figure;
plot(iterations, Cd, 'b-', 'LineWidth', 1.5);
grid on;
xlabel('Iterations');
ylabel('C_d');
title('C_d convergence vs Iterations');

