for n = 1:100
    Dn = find_D();
    Un = find_U();
    Nn = Un - Dn;
    Pn = find_P();
    Tn(1) = T_0;
    for i = 1:length(Nn)
        h = abs(Pn(i)-Pn(i+1));
        Tn_1(i) = Tn(i) + dN/dP();
    end
end
