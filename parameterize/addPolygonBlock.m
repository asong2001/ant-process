function addPolygonBlock(obj,points,height,name,component,material,varargin)
            %add a polygon with any number of sides to the simulations
            %space. Polygon will be aligned in the x-y plane
            p = inputParser;
            p.addParameter('color',[])
            p.addParameter('zmin',0)
            p.parse(varargin{:});
            C = p.Results.color;
            C = C*128;
            zmin = p.Results.zmin;
            %VBA = cell(0,1);
            
            height = obj.checkParam(height);
            zmin = obj.checkParam(zmin);
            
            VBA = sprintf(['With Extrude\n',...
                '.Reset\n',...
                '.Name "%s"\n',...
                '.Component "%s"\n',...
                '.Material "%s"\n',...
                '.Mode "pointlist"\n',...
                '.Height "%s"\n',...
                '.Twist "0.0"\n',...
                '.Taper "0.0"\n',...
                '.Origin "0.0", "0.0", "%s"\n',...
                '.Uvector "1.0", "0.0", "0.0"\n',...
                '.Vvector "0.0", "1.0", "0.0"\n',...
                '.Point "%f", "%f"\n'],...
                name,component,material,height,zmin,points(1,1),points(1,2));
            
            VBA2 = [];
            for i = 2:length(points)
                VBA2 = [VBA2,sprintf('.LineTo "%f", "%f"\n', points(i,1),points(i,2))]; %#ok<AGROW>
            end
            VBA = [VBA,VBA2,sprintf('.create\nEnd With')];
            
            obj.update(['define brick: ',component,':',name],VBA);
            
            %Change color if required
            if ~isempty(C)
                s = obj.mws.invoke('Solid');
                s.invoke('SetUseIndividualColor',[component,':',name],'1');
                s.invoke('ChangeIndividualColor',[component,':',name],num2str(C(1)),num2str(C(2)),num2str(C(3)));
            end
            
        end