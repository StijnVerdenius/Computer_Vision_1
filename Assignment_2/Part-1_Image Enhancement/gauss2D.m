function G = gauss2D( sigma , kernel_size )
    %% solution
    G_xy = gauss1D( sigma , kernel_size )' * gauss1D( sigma , kernel_size );
    G = G_xy/sum(G_xy,'all');
    
end
