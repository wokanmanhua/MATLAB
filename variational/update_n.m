function n=update_n(w, a, b)
% n=update_n(w, a, b)
% Computes update for n_jki (JxKxI) in variational approximation (Buntine & Jakulin
% DCA 2006)
% w: basis - each column is one basis vector (component, psf); (J x K)
% a, b: parameters of the approximative Gamma distribution (KxI each) where
% J=#pixels
% K=#components
% I=#images.

[j,k]=size(w); % j: number of pixels, k: numlber of components 
i=size(a,2); %i: number of images

% expectation of <log(l_k)>:
e_l = psi(a) - log(b); % (K x I) 
% Expand into another dimension for multiplication with w...
e_lreshaped=reshape(e_l,1,k,i); %  (1 x K x I) 

% n-update:
ntmp = bsxfun(@times, w,exp(e_lreshaped)); % (J x K x I)
z=sum(ntmp,2); % normalization constant (J x 1 x I)

%normalized such that sum(n,2)=1 for each k
n=bsxfun(@rdivide, ntmp, z); % (J x K x I) 


