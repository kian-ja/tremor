function subjectName = createSubjectName(name,numSubject)
subjectName = cell(numSubject,1);
for i = 1 : numSubject
    subjectName{i} = [name,'_',num2str(i)];
end
end