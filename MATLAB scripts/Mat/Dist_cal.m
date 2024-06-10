
%%pts at which to record the potential (the virtual electrode contact pts are at these locations)
ptcoord=[0 200 0
         0 100 0
         0 0 0
         0 -100 0
         0 -200 0
         0 -250 0
         0 -300 0
         0 -400 0]* 1e-6; %convert from um to m
     

load points_440neurons_n123.mat

clear pt3d
clear theta
clear center_z
clear center_x
clear center_y

n3dvals= [2
15
2
4
3
2
13
2
16
14
21
34
30
100
21
18
112
59
23
61
97
26
31
5
2
23
16
4
12
20
36
27
17
47
96
83
10
20
34
88
6
17
8
29
20
47
34
4
3
8
7
102
25
40
26
29
25
48
26
12
7
21
26
56
21
16
33
21
3
89
3
4
32
37
31
22
22
20
6
4
5
4
85
14
36
41
2
3
45
10
3
16
4
4
62
6
22
25
28
17
59
48
43
32
7
7
3
4
73
77
7
68
7
10
3
76
7
14
22
3
8
75
2
43
13
56
6
71
9
7
12
62
35
11
61
13
4
48
86
12
32
21
41
35
61
8
26
17
4
34
94
14
11
92
100
52
35
16
23
10
13
50
10
21
17
31
24
5
12
60
49
41
41
11
44
59
63
33
41
38
9
19
54];

no_of_sections = size(n3dvals,1);

for neuron_no = 1:no_of_neurons %go neuron by neuron
    
    line_no=1; %keeps track of which line is being processed
    pt_no=1; %keeps track of the pt no that is being used from the large set of pt3ds 

   line_seg_pts(:,:)=pts(neuron_no,:,:); %get pts for this neuron
    
    for section_no = 1: no_of_sections  %go section by section starting from soma[0]
        
        for lines_per_section = 1: n3dvals(section_no)-1 %go through each line within current section
            
            in_seg(line_no,:) = line_seg_pts(pt_no,:); %save the starting coords of the line
            
            fin_seg(line_no,:) = line_seg_pts(pt_no+1,:); %save the ending coords of the line
            
            line_no = line_no + 1;
            pt_no = pt_no + 1;
            
        end %end of for lines_per_section
        
        pt_no = pt_no + 1;
        
    end %end of for section_no
    
    % convert from µmm
    in_seg = in_seg * 1e-6; %convert from um to m
    fin_seg = fin_seg * 1e-6; %convert from um to m
    
    [h, R, ds]=get_h(ptcoord, in_seg, fin_seg); %get the segment distances 
    
                    
    filename=['neuron_' num2str(neuron_no) '.mat'];
    
    save(filename, 'in_seg', 'fin_seg', 'h', 'R', 'ds');
    
end %end of for neuron_no



            