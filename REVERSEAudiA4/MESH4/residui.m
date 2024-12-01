clear all, close all, clc

%% Residui 
% Specifica il percorso al file log.simpleFoam
filePath = 'log.simpleFoam';

% Leggi il file come testo
fileData = fileread(filePath);

% Estrai le righe che contengono residui per Ux, Uy, Uz, omega, k
residualLines = regexp(fileData, ...
    'Solving for (Ux|Uy|Uz|omega|k|p), Initial residual = ([\d\.e-]+), Final residual = ([\d\.e-]+)', ...
    'tokens');

% Inizializza le variabili
UxResiduals = [];
UyResiduals = [];
UzResiduals = [];
omegaResiduals = [];
kResiduals = [];
pResiduals = [];
iterations = [];

% Itera sulle righe estratte
for i = 1:length(residualLines)
    token = residualLines{i};
    variable = token{1}; % Nome della componente (Ux, Uy, Uz, omega, k)
    finalRes = str2double(token{3}); % Residuo finale
    %initialRes = str2double(token{2}); % Residuo iniziale 

    % Salva il residuo nella variabile corretta
    switch variable
        case 'Ux'
            UxResiduals = [UxResiduals; finalRes];
        case 'Uy'
            UyResiduals = [UyResiduals; finalRes];
        case 'Uz'
            UzResiduals = [UzResiduals; finalRes];
        case 'omega'
            omegaResiduals = [omegaResiduals; finalRes];
        case 'k'
            kResiduals = [kResiduals; finalRes];
        case 'p'
            pResiduals = [pResiduals; finalRes];

    end
end

pResiduals = [pResiduals(3:3:end)];

% Assumi che ci siano N iterazioni
N = max([length(UxResiduals), length(UyResiduals), length(UzResiduals), length(omegaResiduals), length(kResiduals), length(pResiduals)]);
iterations = (1:N)';

% Grafico
figure;
semilogy(iterations, UxResiduals, 'r', 'DisplayName', 'Ux');
hold on;
semilogy(iterations, UyResiduals, 'g', 'DisplayName', 'Uy');
semilogy(iterations, UzResiduals, 'b', 'DisplayName', 'Uz');
semilogy(iterations, omegaResiduals, 'c', 'DisplayName', 'omega');
semilogy(iterations, kResiduals, 'y', 'DisplayName', 'k');
semilogy(iterations, pResiduals, 'm', 'DisplayName', 'p');

grid on;
xlabel('Iterations');
ylabel('Final residuals');
title('Residuals Ux, Uy, Uz, omega, k, p vs Iterations');
legend show;
hold off;