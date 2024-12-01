clear all, close all, clc

%% Impostazioni
logFile = 'log.simpleFoam';  % Percorso del file di log
outputFile1 = 'Ux_residuals.txt';  % File di output per i residui di Ux
outputFile2 = 'Uy_residuals.txt';  % File di output per i residui di Uy
outputFile3 = 'Uz_residuals.txt';  % File di output per i residui di Uz

% Carica il file di log
fid = fopen(logFile, 'r');
if fid == -1
    error('Impossibile aprire il file di log.');
end

% Inizializza un array per i residui finali di Ux,y,z, p, k, omega
Ux_residuals = [];
Uy_residuals = [];
Uz_residuals = [];

% Leggi il file riga per riga
while ~feof(fid)
    line = fgetl(fid);
    
    % Cerca le righe che contengono informazioni sui residui per Ux
    if contains(line, 'Solving for Ux')
        % Trova i residui finali (espressione regolare per la riga)
        expr = 'Solving for Ux, Initial residual = (\S+), Final residual = (\S+)';
        tokens = regexp(line, expr, 'tokens');
        
        if ~isempty(tokens)
            % Estrai il residuo finale di Ux
            finalResidual1 = str2double(tokens{1}{2});  % Residuo finale
            Ux_residuals = [Ux_residuals, finalResidual1];  % Aggiungi al vettore
        end
    end

    % Cerca le righe che contengono informazioni sui residui per Uy
    if contains(line, 'Solving for Uy')
        % Trova i residui finali (espressione regolare per la riga)
        expr = 'Solving for Uy, Initial residual = (\S+), Final residual = (\S+)';
        tokens = regexp(line, expr, 'tokens');
        
        if ~isempty(tokens)
            % Estrai il residuo finale di Uy
            finalResidual2 = str2double(tokens{1}{2});  % Residuo finale
            Uy_residuals = [Uy_residuals, finalResidual2];  % Aggiungi al vettore
        end
    end


    % Cerca le righe che contengono informazioni sui residui per Ux
    if contains(line, 'Solving for Uz')
        % Trova i residui finali (espressione regolare per la riga)
        expr = 'Solving for Uz, Initial residual = (\S+), Final residual = (\S+)';
        tokens = regexp(line, expr, 'tokens');
        
        if ~isempty(tokens)
            % Estrai il residuo finale di Ux
            finalResidual3 = str2double(tokens{1}{2});  % Residuo finale
            Uz_residuals = [Uz_residuals, finalResidual3];  % Aggiungi al vettore
        end
    end


end

% Chiudi il file di log
fclose(fid);

% Scrivi i residui finali di Ux,y,z in un file di testo
fidOut1 = fopen(outputFile1, 'w');
fidOut2 = fopen(outputFile2, 'w');
fidOut3 = fopen(outputFile3, 'w');

fprintf(fidOut1, 'Residuo Finale di Ux\n');
fprintf(fidOut2, 'Residuo Finale di Uy\n');
fprintf(fidOut3, 'Residuo Finale di Uz\n');

for i = 1:length(Ux_residuals)
    fprintf(fidOut1, '%g\n', Ux_residuals(i));
end

for i = 1:length(Uy_residuals)
    fprintf(fidOut2, '%g\n', Uy_residuals(i));
end

for i = 1:length(Uz_residuals)
    fprintf(fidOut3, '%g\n', Uz_residuals(i));
end

fclose(fidOut1);
fclose(fidOut2);
fclose(fidOut3);

%% Plots
iterations = 1:1000;

figure;

semilogy(iterations, Ux_residuals, 'b-', 'LineWidth', 2);
hold on
semilogy(iterations, Uy_residuals, 'r-', 'LineWidth', 2);
hold on
semilogy(iterations, Uz_residuals, 'g-', 'LineWidth', 2);

xlabel('Iterations');
ylabel('Residuals');
title('Residuals plot');
grid on;

