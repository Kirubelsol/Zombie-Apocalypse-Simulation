%size of field (100x100)
size = 100; 
%simulation time steps 
steps = 100000; 
time_step = 1:100000;

%probability of humans/zombies filling cells
phumans = 0.6; 
pzombies = 0.2;
pempty = 0.2;

% Create 100x100 field (-1 = zombie , 0 = empty, 1 = human)
field = randsrc(size,size,[-1,0,1;pzombies,pempty,phumans]);
Field_track = zeros(size,size,steps+1);
Field_track(:,:,1) = field;

% phh,phz = probability of human killing human and human killing zombie
phh = 0.3;
phz = 0.1;

humanPopulation = zeros(steps,1);
zombiePopulation = zeros(steps,1);
emptyPopulation = zeros(steps,1);
populationRatio = zeros(steps,1); 
%simulate
for i = 1:steps
    %select a cell with index i,j and index of the target cell k,l to move to 
    [Field_ij,Field_kl] = find_target(field,size);
    %update the selected and target cell based on phh and phz
    field = updateField(Field_ij, Field_kl, phz, phh, field);
    Field_track(:,:,i+1) = field;  

    %keep track of normalized human and zombie population
    humanPopulation(i) = sum(field(:) == 1)/(size^2);
    zombiePopulation(i) = sum(field(:) == -1)/(size^2);
    emptyPopulation(i) = sum(field(:) == 0)/(size^2);
    populationRatio(i) = humanPopulation(i)/zombiePopulation(i);
end

bargraphAnimation(humanPopulation,zombiePopulation,emptyPopulation,steps,fileName);
contourAnimation(Field_track,steps,contourFile);

   ...................