function saveFigure(app,filename,V,C,Cerr,leg)
    logMessage(app,'Saving figure.');
    % Define an array of linespec
    ls = ['o','s','d','^','v','>','<','p'];
    % create an invisible figure
    h = figure;
    h.Visible   = 'off';
    matrixSize  = size(C);
    NPOINTS     = matrixSize(1);
    NPINS       = matrixSize(2);
    % Define a color palette for the pins
    cp = cool(NPINS);
    hold on
    for i = 1:NPINS
        errorbar(V,C(:,i),Cerr(:,i),ls(i),'Color',cp(i,:));
    end % for i = 1:NPINS
    hold off
    lgd = legend(leg);
    lgd.Box = app.CVAxes.Legend.Box;
    box on
    set(gca,'FontSize',14);
    % Copy the format from the app
    lgd.Location                    = app.CVAxes.Legend.Location;
    h.CurrentAxes.YLabel.String     = app.CVAxes.YLabel.String;
    h.CurrentAxes.YLabel.FontSize   = 18;%app.CVAxes.YLabel.FontSize;
%     h.CurrentAxes.YLabel.FontWeight = 'Bold';
    h.CurrentAxes.XLabel.String     = app.CVAxes.XLabel.String;
    h.CurrentAxes.XLabel.FontSize   = 18;%app.CVAxes.XLabel.FontSize;
%     h.CurrentAxes.XLabel.FontWeight = 'Bold';
    h.CurrentAxes.Title.String      = app.CVAxes.Title.String;
    h.CurrentAxes.Title.FontSize    = app.CVAxes.Title.FontSize;

    export_fig(h,strcat(filename,'.png'),'-png','-native');
%     print(strcat(filetag,'.png'),'-dpng','-r300');
    savefig(h,strcat(filename,'.fig'))
    delete(h)
end