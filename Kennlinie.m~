%% Kennlinie(Funktion,Funktionsparameter)
% Erstellt einen Kennlinienplot für die angegebene Funktion mit den 
% angegebenen Funktionsparameter als Cell-Array.
% Implementierte Funktionen:
%   - sensor.m => signal = sensor( Blendenwinkel, Unit, Sensorkonstanten)
function Kennlinie(Funktion,Schrittzahl,Funktionsparameter)
Wertebereich = linspace(-Funktionsparameter{2}{3},Funktionsparameter{2}{3},Schrittzahl);

switch Funktion
    case 'sensor.m'
        figure(); hold on;
        for i = 1:1:size(Wertebereich,2)
            signal(i) = sensor(Wertebereich(i));
        end
        fig = plot(Wertebereich,signal);
        xlabel('Winkelposition des Spiegels / rad')
        ylabel('Spannungssignal des Sensorsmoduls / V')
        title(['Sensor-Kennlinie, mode = ',Funktionsparameter{1}])
        saveas(fig,['/home/kizzm/Master/Repos/syt_ss13/Plots/','Sensor-Kennlinie_',Funktionsparameter{1},'.jpg']);
        hold off;
        

end
end