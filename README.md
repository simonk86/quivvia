# quivvia
Quasar upright in-vivo voltage imaging analysis
Simon Kheifets
Cohen Lab
2018

updated 6/20/2018

Data Organization:

VMD					%Voltage Movie Data 
	-set
		-sin		%settings as given to the vmd_importData function
		-dir		%directory which houses movie and other data
		-transpose	%transpose flag when loading movie? (not always saved in same format)
		-dt			%time step
		-t0			%start time
		-calcvar	%calculate variance?
		-label		%descriptive string
		-platform	%'Windows' or 'Unix', to correct for different path formats
	-mov			%raw movie data (vm object)
	-label			%short descriptive string
	-tvec			%time vector for plotting
	-dt				%time step
	-duration		%duration of movie
	-meanimg		%mean image
	-varimg			%variance image
	-meantrace		%mean trace
    -vartrace       %variance trace
	-info			%...?
	-fvm			% (array) of FVM (filtered voltage movie) objects
	
FVM 				%Filtered Voltage Movie
	-parent			%parent VMD object
	-set			%settings/parameters for various filter steps
		-sin		
		-tlim
		-label
		-cropmotion
		-dopblc
		-removerownoise
		-nbin
		-fixdmdframes
		-hpsamples
		-rmbloodflow
	-mov
	-tvec
	-spectrogram
	-meanimg
	-meantrace
	-duration
	-label
	-varimg
	-dmov
	-movHP
	-movLP
	-meanimgHP
	-meanimgLP
	-varimgHP
	-varimgLP
	-meantraceHP
	-meantraceLP
	-PCAobj			% (array) of PCAobj objects
	-ICAobj			% currently not used, ICAobj stored as child of PCAobj
	
PCAobj
	-parent
	-set
		-sin
		-npc
	-timestamp
	-uvm
	-d
	-v
	-npc
	-stats
	-more
	-ICAobj
	
ICAobj
	-parent
	-set
		-(sin)
		-nic
		-pkeep
		-alpha
	-timestamp
	-nics
	-more
	-filters
	-footprints
	-traces
	-sepmat
	-mixmat
	-icells
	-stats
	-vunits 		% array of vUnit (putative cells) objects 
	
VUNIT
	-parent
	-calcmethod		%{'ICA'}...
	-index 
	-timestamp
	-footprint
	-filter
	-timetrace
    -timetracelp
    -timetracenp
	-com			%center of mass (pixels for now)
	-sigma			%second moment		
	-stats
	
	