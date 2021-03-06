% DEMO_KPCADENOIS Idea of image denoising based on Kernel PCA.
%
% Description:
%  The kernel PCA model is trained for to model input 2D vectors.
%  The free model parameters (kernel argument, dimension) are 
%  tuned by the script train_kpca_denois. The denosing of corrupted 
%  vectors is based on projecting onto the kernel PCA model and 
%  take the resulting image as the reconstructed vector [Mika99b]. This 
%  idea is demonstrated on a toy 2D data. 
%  
% See also 
%  GREEDYKPCA, KPCAREC, KPCA.
%

% About: Statistical Pattern Recognition Toolbox
% (C) 1999-2003, Written by Vojtech Franc and Vaclav Hlavac
% <a href="http://www.cvut.cz">Czech Technical University Prague</a>
% <a href="http://www.feld.cvut.cz">Faculty of Electrical Engineering</a>
% <a href="http://cmp.felk.cvut.cz">Center for Machine Perception</a>

% Modifications:
% 06-jun2004, VF

help img_denois_idea;

% setting 
%---------------------------------------

% toy data generated by gencircledata
input_data_file = 'noisy_circle';  

options.ker = 'rbf';  % kernel
options.arg = 2;      % kernel argument
options.m = 500;      % #of vectors used for approximation
options.p = 10;       % deth of search for the best basis vector
options.new_dim = 2;  % output dimension
options.verb = 1;   

% load training data containing examples of corrupted and 
% corresponding ground truth vectors.
load(input_data_file,'trn');
[Dim,Num_Data] = size(trn.X);

% train kernel PCA
kpca_model = greedykpca(trn.X,options);

% example of corrupted vector out of kernel PCA subspace
corr_x = [-2;4.5];

% vector reconstruction
rec_x = kpcarec(corr_x,kpca_model);

% visualization
figure; hold on; axis([-4 7 -4 7]);
h0=ppatterns(trn.gnd_X,'r+');
h1=ppatterns(trn.X,'gx');
h3=ppatterns(rec_x,'bo',13);
h2=ppatterns(corr_x,'mo',13);
plot([rec_x(1) corr_x(1)],[rec_x(2) corr_x(2)],'k--');
h4 = legend([h0 h1 h2 h3],'Ground truth','Noisy examples',...
    'Corrupted','Reconstructed');
set(h4,'FontSize',13);

% EOF