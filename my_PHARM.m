function my_PHARM(image_path, feature_path, QF)

QF = uint32(QF);
files = dir([image_path '\*.jpg']);
file_num = length(files);
F = single( zeros(file_num,12600) );
names = cell(file_num,1);

parfor w = 1:file_num
    tic
    jpegfilename = [image_path '\' files(w).name]; 
    ImageSet = {jpegfilename};  % ImageSet是cell数据类型
    fea = PHARM(ImageSet, QF);  % fea是struct数据类型
    c = struct2cell(fea);     
    f = [];
    for i = 1:length(c)
        f = [f;c{i}];   
    end
    F(w,:) = f(:);      
    % names{w} = [num2str(w) '.jpg'];
    names{w} = files(w).name;
    toc;
end
save(feature_path,'F','names');
% save(feature_path,'F','names','-v7.3');