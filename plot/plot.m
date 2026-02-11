% MATLAB code to read a CSV file and plot it

% Ask user to select the CSV file
[file, path] = uigetfile('*.csv', 'Select CSV file');
if isequal(file,0)
    disp('User canceled file selection');
else
    filename = fullfile(path, file);
    
    % Read the CSV file
    data = readmatrix(filename);  % Automatically handles numeric CSV
    
    % Check if file has at least 2 columns
    if size(data,2) < 2
        error('CSV file must have at least 2 columns for x and y data.');
    end
    
    x = data(:,1);  % First column
    y = data(:,2);  % Second column
    
    % Plot the data
    figure;
    plot(x, y, '-o', 'LineWidth', 1.5, 'MarkerSize', 6);
    grid on;
    xlabel('X-axis');
    ylabel('Y-axis');
    title('Plot from CSV file');
    legend('Data');
end
