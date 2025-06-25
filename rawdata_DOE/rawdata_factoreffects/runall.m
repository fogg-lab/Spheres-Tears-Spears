clear all; close all;clc

files = 6;



name = {'CI_1','p_1','CI_1p5','p_1p5','CI_2','p_2'};
yaxis = {{'';'\boldmath$\mathsf{{Circularity \: C_I}}$'}, ...
    {'';'\boldmath$\mathsf{{perimeter \: p}}$'}, ...
    {'';'\boldmath$\mathsf{{Circularity \: C_I}}$'}, ...
    {'';'\boldmath$\mathsf{{perimeter \: p}}$'},...
    {'';'\boldmath$\mathsf{{Circularity \: C_I}}$'},...
    {'';'\boldmath$\mathsf{{perimeter \: p}}$'}};
linetype = {"-","--","-."};
linewid = 3;
cols = {'#882255','#44AA99','#DDCC77'}; % original colors selected;
% cols = {'#333333','#666666','#999999'};
% lim = {[0 1], [0 10], [0 1], [0 10],[0 1], [0 10]};
legloc = {"northeast","northeast","northeast","northeast","northeast","northeast"};
conclabel = {"\boldmath$\mathsf{{C_{AG} = 1 \: \% w/v}}$","\boldmath$\mathsf{{C_{AG} = 1 \: \% w/v}}$",...
    "\boldmath$\mathsf{{C_{AG} = 1.5 \: \% w/v}}$","\boldmath$\mathsf{{C_{AG} = 1.5 \: \% w/v}}$",...
    "\boldmath$\mathsf{{C_{AG} = 2 \: \% w/v}}$","\boldmath$\mathsf{{C_{AG} = 2\: \% w/v}}$"};
ytickform = {'%.3f','%.2f','%.2f','%.2f','%.2f','%.2f'};
for i = 1:files
    filename = num2str(i) + ".xlsx"

data = readtable(filename);


PVAx = data.pva; 
PVAy = data.ypva;
AGx = data.ag;
AGy = data.yag;
tx = data.time;
ty = data.yt;

limt = max(max([PVAy AGy ty]))+max(max([PVAy AGy ty]))*0.01;
limb = min(min([PVAy AGy ty]))-min(min([PVAy AGy ty]))*0.01;

if i <= 2 
    cenp = 0.16;
    mult = 0.1;
elseif i > 2 & i <= 4
    cenp = 0.014;
    mult = 0.0085;
elseif i > 4 & i <= 6
    cenp = 0.001725;
    mult = 0.000975;
end

PVAx = (PVAx-cenp)./mult;
AGx = (AGx - 1.1)./0.9;
tx = (tx - 2.5)./2.5;
number = 3; % change this based on which figure

figure(i)
hold on
pva = plot(NaN,NaN,linetype{1},'LineWidth',linewid,'Color',cols{1});
ag = plot(NaN,NaN,linetype{2},'LineWidth',linewid,'Color', cols{2});
t = plot(NaN,NaN,linetype{3},'LineWidth',linewid,'Color',cols{3});
pva1 = plot(PVAx,PVAy,linetype{1},'LineWidth',linewid,'Color',cols{1});
ag1 = plot(AGx,AGy,linetype{2},'LineWidth',linewid,'Color', cols{2});
t1 = plot(tx,ty,linetype{3},'LineWidth',linewid,'Color',cols{3});
box on
leg = legend([pva;ag;t],{'Re';'f';'Qa'},'Location',legloc{i})
xlab = xlabel(['\textbf{\textsf{factor value [coded units]}}'],'Interpreter','latex');
ylab = ylabel(yaxis{i},'Interpreter','latex');
% yticks([50 60 70 80 90 100])
ytickformat(ytickform{i})
ax = gca;
ax.FontSize = 22;
ax.LineWidth = 3;
leg.LineWidth = 3;
leg.FontSize = 18;
dim = [0.25 0.03 0.3 0.3];
tt = annotation('textbox',dim,'String',conclabel{i},'FitBoxToText','on');
tt.LineWidth = 3;
tt.Interpreter = 'latex';
tt.FontSize = 18;
tt.BackgroundColor = 'w';
% ylim([limb limt]);
xlim([-2 2]);
figfilename = "figures\" + num2str(i);
print(figfilename,'-dtiffn','-r220')
box on
hold off
end