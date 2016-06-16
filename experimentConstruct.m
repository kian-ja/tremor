experiment.fileName{1} = '/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Data/DLG_230316.flb';
experiment.fileName{2} = '/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Data/ES_070416.flb';
experiment.fileName{3} = '/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Data/IH_010616.flb';
experiment.fileName{4} = '/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Data/KJ_300516.flb';
experiment.fileName{5} = '/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Data/MG_270516.flb';
experiment.fileName{6} = '/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Data/MR_300516.flb';
experiment.fileName{7} = '/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Data/PA_220316.flb';

%%%%
experiment.DF.MVC{1} = 2;
experiment.DF.Passive{1} = 3;
experiment.DF.Trials{1} = [4,5,6];

experiment.DF.MVC{2} = 2;
experiment.DF.Passive{2} = 11;
experiment.DF.Trials{2} = [12,13,14];

experiment.DF.MVC{3} = 1;
experiment.DF.Passive{3} = 8;
experiment.DF.Trials{3} = [9,10,11];

experiment.DF.MVC{4} = 1;
experiment.DF.Passive{4} = 17;
experiment.DF.Trials{4} = [18,19,20];

experiment.DF.MVC{5} = 1;
experiment.DF.Passive{5} = 11;
experiment.DF.Trials{5} = [12 14 15 16];

experiment.DF.MVC{6} = 1;
experiment.DF.Passive{6} = 9;
experiment.DF.Trials{6} = [10,11,12];

experiment.DF.MVC{7} = 2;
experiment.DF.Passive{7} = 3;
experiment.DF.Trials{7} = [4,5,6];

%%%%%%

experiment.PF1.MVC{1} = 8;
experiment.PF1.Passive{1} = 9;
experiment.PF1.Trials{1} = [10,11,12];

experiment.PF1.MVC{2} = 1;
experiment.PF1.Passive{2} = 7;
experiment.PF1.Trials{2} = [8,9,10];

experiment.PF1.MVC{3} = 2;
experiment.PF1.Passive{3} = 4;
experiment.PF1.Trials{3} = [5,6,7];

experiment.PF1.MVC{4} = 2;
experiment.PF1.Passive{4} = 13;
experiment.PF1.Trials{4} = [14,15,16];

experiment.PF1.MVC{5} = 2;
experiment.PF1.Passive{5} = 5;
experiment.PF1.Trials{5} = [6,7,8,9,10];

experiment.PF1.MVC{6} = 2;
experiment.PF1.Passive{6} = 4;
experiment.PF1.Trials{6} = [5,6,7];

experiment.PF1.MVC{7} = 8;
experiment.PF1.Passive{7} = 9;
experiment.PF1.Trials{7} = [10,11,12];


%%%%%%

experiment.PF2.MVC{1} = 13;
experiment.PF2.Passive{1} = 14;
experiment.PF2.Trials{1} = [18,19,20];
experiment.PF2.MVC20.Trials{1} = [15,16,17];
experiment.PF2.MVC30.Trials{1} = [18,19,20];
experiment.PF2.MVC40.Trials{1} = [21,22,23];

experiment.PF2.MVC{2} = 5;
experiment.PF2.Passive{2} = 15;
experiment.PF2.Trials{2} = [16,20,21];
experiment.PF2.MVC20.Trials{2} = [17,19,23];
experiment.PF2.MVC30.Trials{2} = [16,20,21];
experiment.PF2.MVC40.Trials{2} = [18,22,24];

experiment.PF2.MVC{3} = 3;
experiment.PF2.Passive{3} = 12;
experiment.PF2.Trials{3} = [13,17,18];
experiment.PF2.MVC20.Trials{3} = [14,16,19];
experiment.PF2.MVC30.Trials{3} = [13,17,18];
experiment.PF2.MVC40.Trials{3} = [15,20];

experiment.PF2.MVC{4} = 3;
experiment.PF2.Passive{4} = 21;
experiment.PF2.Trials{4} = [22,27,28];
experiment.PF2.MVC20.Trials{4} = [23,25,26,30];
experiment.PF2.MVC30.Trials{4} = [22,27,28];
experiment.PF2.MVC40.Trials{4} = [24,29,31];

experiment.PF2.MVC{5} = 3;
experiment.PF2.Passive{5} = 17;
experiment.PF2.Trials{5} = [19,23,24];
experiment.PF2.MVC20.Trials{5} = [20,22,26,28];
experiment.PF2.MVC30.Trials{5} = [19,23,24];
experiment.PF2.MVC40.Trials{5} = [21,25,27,29];

experiment.PF2.MVC{6} = 3;
experiment.PF2.Passive{6} = 13;
experiment.PF2.Trials{6} = [14,18,19];
experiment.PF2.MVC20.Trials{6} = [15,17,21];
experiment.PF2.MVC30.Trials{6} = [14,18,19];
experiment.PF2.MVC40.Trials{6} = [16,20,22];

experiment.PF2.MVC{7} = 13;
experiment.PF2.Passive{7} = 14;
experiment.PF2.Trials{7} = [18,19,20];
experiment.PF2.MVC20.Trials{7} = [15,16,17];
experiment.PF2.MVC30.Trials{7} = [18,19,20];
experiment.PF2.MVC40.Trials{7} = [21,22,23];
%%
save experimentTrials experiment