function htext_title = Arrow_Title(ha,str,Attribute_Set)
% htext_title = Arrow_Title(ha,str,pos,Attribute_Set)
% ���ü�ͷ������ͼ�εı���(Title)
% ha              ������(axes)�����Ĭ��Ϊ��ǰ��������
% str             �ַ���
% Attribute_Set   ��ע�ı��������ã�Textbox�����Ծ���������
%                 ӦΪ����Ԫ�����飬һ��Ϊ����������һ��Ϊ����ֵ
% htext_title         ��ע�ı��ľ����Ҳ��ͨ�������������ı�����
% By ZFS@wust 2012.04.21
% See Also: Arrow_XY, Arrow_Xlabel, Arrow_Ylabel, plot_with_arrow
% ��ȡ����Matlab/Simulinkԭ�����Ϻͳ������ע΢�Ź��ںţ�Matlab Fans

% ����Ĭ��ֵ
if nargin < 3 
    Attribute_Set = [];
end
if isempty(ha)   % Ĭ��Ϊ��ǰ������
    ha = gca;
end


% ���ı���Ӧ�÷��õ�λ��
rec = get( ha,'position' );                  % ������λ��
ty = rec(2) + rec(4) + 0.01;
tx0 = rec(1);
text_pos = [tx0 ty rec(3) 0.1];


% �����ı��򣬲����û�������
hf = get(ha,'parent');      % ��ȡ�������ͼ�ξ��
htext_title = annotation(hf,'textbox',text_pos);
color = get(hf,'color');    % ��ȡfigure������ɫ
set(htext_title,'String',str,'EdgeColor',color,'VerticalAlignment','bottom','HorizontalAlignment','center','FitBoxToText','on','Margin',0); 
                            % �߿���ɫΪfigure������ɫ�������¶���,�Զ��������ο����ʺ����֣����ο����Ϊ0

           
% ���ø�������
if ~isempty(Attribute_Set)
  [m n] = size(Attribute_Set);    % mΪ��Ҫ���õ�������Ŀ��n����Ϊ2                        
  if m == 2 && n == 1
           set( htext_title,Attribute_Set{ii,1},Attribute_Set{ii,2} );
  elseif n ~= 2
      error('Attribute_Set must be Two-Row Cell Matrix��');
  else
      for ii = 1:m
           set( htext_title,Attribute_Set{ii,1},Attribute_Set{ii,2} ); 
      end
  end
end

