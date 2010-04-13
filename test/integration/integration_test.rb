require File.join(File.dirname(__FILE__),'..', 'test_helper')

class IntegrationTest < Test::Unit::TestCase

  CORPUS1 = { 'access'=> 'acess', 'accessing'=> 'accesing', 'accommodation'=>
    'accomodation acommodation acomodation', 'account'=> 'acount', 'address'=>
    'adress adres', 'addressable'=> 'addresable', 'arranged'=> 'aranged arrainged',
    'arrangeing'=> 'aranging', 'arrangement'=> 'arragment', 'articles'=> 'articals',
    'aunt'=> 'annt anut arnt', 'auxiliary'=> 'auxillary', 'available'=> 'avaible',
    'awful'=> 'awfall afful', 'basically'=> 'basicaly', 'beginning'=> 'begining',
    'benefit'=> 'benifit', 'benefits'=> 'benifits', 'between'=> 'beetween', 'bicycle'=>
    'bicycal bycicle bycycle', 'biscuits'=> 
    'biscits biscutes biscuts bisquits buiscits buiscuts', 'built'=> 'biult', 
    'cake'=> 'cak', 'career'=> 'carrer',
    'cemetery'=> 'cemetary semetary', 'centrally'=> 'centraly', 'certain'=> 'cirtain',
    'challenges'=> 'chalenges chalenges', 'chapter'=> 'chaper chaphter chaptur',
    'choice'=> 'choise', 'choosing'=> 'chosing', 'clerical'=> 'clearical',
    'committee'=> 'comittee', 'compare'=> 'compair', 'completely'=> 'completly',
    'consider'=> 'concider', 'considerable'=> 'conciderable', 'contented'=>
    'contenpted contende contended contentid', 'curtains'=> 
    'cartains certans courtens cuaritains curtans curtians curtions', 'decide'=> 'descide', 'decided'=>
    'descided', 'definitely'=> 'definately difinately', 'definition'=> 'defenition',
    'definitions'=> 'defenitions', 'description'=> 'discription', 'desiccate'=>
    'desicate dessicate dessiccate', 'diagrammatically'=> 'diagrammaticaally',
    'different'=> 'diffrent', 'driven'=> 'dirven', 'ecstasy'=> 'exstacy ecstacy',
    'embarrass'=> 'embaras embarass', 'establishing'=> 'astablishing establising',
    'experience'=> 'experance experiance', 'experiences'=> 'experances', 'extended'=>
    'extented', 'extremely'=> 'extreamly', 'fails'=> 'failes', 'families'=> 'familes',
    'february'=> 'febuary', 'further'=> 'futher', 'gallery'=> 'galery gallary gallerry gallrey', 
    'hierarchal'=> 'hierachial', 'hierarchy'=> 'hierchy', 'inconvenient'=>
    'inconvienient inconvient inconvinient', 'independent'=> 'independant independant',
    'initial'=> 'intial', 'initials'=> 'inetials inistals initails initals intials',
    'juice'=> 'guic juce jucie juise juse', 'latest'=> 'lates latets latiest latist', 
    'laugh'=> 'lagh lauf laught lugh', 'level'=> 'leval',
    'levels'=> 'levals', 'liaison'=> 'liaision liason', 'lieu'=> 'liew', 'literature'=>
    'litriture', 'loans'=> 'lones', 'locally'=> 'localy', 'magnificent'=> 
    'magnificnet magificent magnifcent magnifecent magnifiscant magnifisent magnificant',
    'management'=> 'managment', 'meant'=> 'ment', 'minuscule'=> 'miniscule',
    'minutes'=> 'muinets', 'monitoring'=> 'monitering', 'necessary'=> 
    'neccesary necesary neccesary necassary necassery neccasary', 'occurrence'=>
    'occurence occurence', 'often'=> 'ofen offen offten ofton', 'opposite'=> 
    'opisite oppasite oppesite oppisit oppisite opposit oppossite oppossitte', 'parallel'=> 
    'paralel paralell parrallel parralell parrallell', 'particular'=> 'particulaur',
    'perhaps'=> 'perhapse', 'personnel'=> 'personnell', 'planned'=> 'planed', 'poem'=>
    'poame', 'poems'=> 'poims pomes', 'poetry'=> 'poartry poertry poetre poety powetry', 
    'position'=> 'possition', 'possible'=> 'possable', 'pretend'=> 
    'pertend protend prtend pritend', 'problem'=> 'problam proble promblem proplen',
    'pronunciation'=> 'pronounciation', 'purple'=> 'perple perpul poarple',
    'questionnaire'=> 'questionaire', 'really'=> 'realy relley relly', 'receipt'=>
    'receit receite reciet recipt', 'receive'=> 'recieve', 'refreshment'=>
    'reafreshment refreshmant refresment refressmunt', 'remember'=> 'rember remeber rememmer rermember',
    'remind'=> 'remine remined', 'scarcely'=> 'scarcly scarecly scarely scarsely', 
    'scissors'=> 'scisors sissors', 'separate'=> 'seperate',
    'singular'=> 'singulaur', 'someone'=> 'somone', 'sources'=> 'sorces', 'southern'=>
    'southen', 'special'=> 'speaical specail specal speical', 'splendid'=> 
    'spledid splended splened splended', 'standardizing'=> 'stanerdizing', 'stomach'=> 
    'stomac stomache stomec stumache', 'supersede'=> 'supercede superceed', 'there'=> 'ther',
    'totally'=> 'totaly', 'transferred'=> 'transfred', 'transportability'=>
    'transportibility', 'triangular'=> 'triangulaur', 'understand'=> 'undersand undistand', 
    'unexpected'=> 'unexpcted unexpeted unexspected', 'unfortunately'=>
    'unfortunatly', 'unique'=> 'uneque', 'useful'=> 'usefull', 'valuable'=> 'valubale valuble', 
    'variable'=> 'varable', 'variant'=> 'vairiant', 'various'=> 'vairious',
    'visited'=> 'fisited viseted vistid vistied', 'visitors'=> 'vistors',
    'voluntary'=> 'volantry', 'voting'=> 'voteing', 'wanted'=> 'wantid wonted',
    'whether'=> 'wether', 'wrote'=> 'rote wote'}

  CORPUS2 = {'forbidden'=> 'forbiden', 'decisions'=> 'deciscions descisions',
    'supposedly'=> 'supposidly', 'embellishing'=> 'embelishing', 'technique'=>
    'tecnique', 'permanently'=> 'perminantly', 'confirmation'=> 'confermation',
    'appointment'=> 'appoitment', 'progression'=> 'progresion', 'accompanying'=>
    'acompaning', 'applicable'=> 'aplicable', 'regained'=> 'regined', 'guidelines'=>
    'guidlines', 'surrounding'=> 'serounding', 'titles'=> 'tittles', 'unavailable'=>
    'unavailble', 'advantageous'=> 'advantageos', 'brief'=> 'brif', 'appeal'=>
    'apeal', 'consisting'=> 'consisiting', 'clerk'=> 'cleark clerck', 'component'=>
    'componant', 'favourable'=> 'faverable', 'separation'=> 'seperation', 'search'=>
    'serch', 'receive'=> 'recieve', 'employees'=> 'emploies', 'prior'=> 'piror',
    'resulting'=> 'reulting', 'suggestion'=> 'sugestion', 'opinion'=> 'oppinion',
    'cancellation'=> 'cancelation', 'criticism'=> 'citisum', 'useful'=> 'usful',
    'humour'=> 'humor', 'anomalies'=> 'anomolies', 'would'=> 'whould', 'doubt'=>
    'doupt', 'examination'=> 'eximination', 'therefore'=> 'therefoe', 'recommend'=>
    'recomend', 'separated'=> 'seperated', 'successful'=> 'sucssuful succesful',
    'apparent'=> 'apparant', 'occurred'=> 'occureed', 'particular'=> 'paerticulaur',
    'pivoting'=> 'pivting', 'announcing'=> 'anouncing', 'challenge'=> 'chalange',
    'arrangements'=> 'araingements', 'proportions'=> 'proprtions', 'organized'=>
    'oranised', 'accept'=> 'acept', 'dependence'=> 'dependance', 'unequalled'=>
    'unequaled', 'numbers'=> 'numbuers', 'sense'=> 'sence', 'conversely'=>
    'conversly', 'provide'=> 'provid', 'arrangement'=> 'arrangment',
    'responsibilities'=> 'responsiblities', 'fourth'=> 'forth', 'ordinary'=>
    'ordenary', 'description'=> 'desription descvription desacription',
    'inconceivable'=> 'inconcievable', 'data'=> 'dsata', 'register'=> 'rgister',
    'supervision'=> 'supervison', 'encompassing'=> 'encompasing', 'negligible'=>
    'negligable', 'allow'=> 'alow', 'operations'=> 'operatins', 'executed'=>
    'executted', 'interpretation'=> 'interpritation', 'hierarchy'=> 'heiarky',
    'indeed'=> 'indead', 'years'=> 'yesars', 'through'=> 'throut', 'committee'=>
    'committe', 'inquiries'=> 'equiries', 'before'=> 'befor', 'continued'=>
    'contuned', 'permanent'=> 'perminant', 'choose'=> 'chose', 'virtually'=>
    'vertually', 'correspondence'=> 'correspondance', 'eventually'=> 'eventully',
    'lonely'=> 'lonley', 'profession'=> 'preffeson', 'they'=> 'thay', 'now'=> 'noe',
    'desperately'=> 'despratly', 'university'=> 'unversity', 'adjournment'=>
    'adjurnment', 'possibilities'=> 'possablities', 'stopped'=> 'stoped', 'mean'=>
    'meen', 'weighted'=> 'wagted', 'adequately'=> 'adequattly', 'shown'=> 'hown',
    'matrix'=> 'matriiix', 'profit'=> 'proffit', 'encourage'=> 'encorage', 'collate'=>
    'colate', 'disaggregate'=> 'disaggreagte disaggreaget', 'receiving'=>
    'recieving reciving', 'proviso'=> 'provisoe', 'umbrella'=> 'umberalla', 'approached'=>
    'aproached', 'pleasant'=> 'plesent', 'difficulty'=> 'dificulty', 'appointments'=>
    'apointments', 'base'=> 'basse', 'conditioning'=> 'conditining', 'earliest'=>
    'earlyest', 'beginning'=> 'begining', 'universally'=> 'universaly',
    'unresolved'=> 'unresloved', 'length'=> 'lengh', 'exponentially'=>
    'exponentualy', 'utilized'=> 'utalised', 'set'=> 'et', 'surveys'=> 'servays',
    'families'=> 'familys', 'system'=> 'sysem', 'approximately'=> 'aproximatly',
    'their'=> 'ther', 'scheme'=> 'scheem', 'speaking'=> 'speeking', 'repetitive'=>
    'repetative', 'inefficient'=> 'ineffiect', 'geneva'=> 'geniva', 'exactly'=>
    'exsactly', 'immediate'=> 'imediate', 'appreciation'=> 'apreciation', 'luckily'=>
    'luckeley', 'eliminated'=> 'elimiated', 'believe'=> 'belive', 'appreciated'=>
    'apreciated', 'readjusted'=> 'reajusted', 'were'=> 'wer where', 'feeling'=>
    'fealing', 'and'=> 'anf', 'false'=> 'faulse', 'seen'=> 'seeen', 'interrogating'=>
    'interogationg', 'academically'=> 'academicly', 'relatively'=> 'relativly relitivly',
    'traditionally'=> 'traditionaly', 'studying'=> 'studing',
    'majority'=> 'majorty', 'build'=> 'biuld', 'aggravating'=> 'agravating',
    'transactions'=> 'trasactions', 'arguing'=> 'aurguing', 'sheets'=> 'sheertes',
    'successive'=> 'sucsesive sucessive', 'segment'=> 'segemnt', 'especially'=>
    'especaily', 'later'=> 'latter', 'senior'=> 'sienior', 'dragged'=> 'draged',
    'atmosphere'=> 'atmospher', 'drastically'=> 'drasticaly', 'particularly'=>
    'particulary', 'visitor'=> 'vistor', 'session'=> 'sesion', 'continually'=>
    'contually', 'availability'=> 'avaiblity', 'busy'=> 'buisy', 'parameters'=>
    'perametres', 'surroundings'=> 'suroundings seroundings', 'employed'=>
    'emploied', 'adequate'=> 'adiquate', 'handle'=> 'handel', 'means'=> 'meens',
    'familiar'=> 'familer', 'between'=> 'beeteen', 'overall'=> 'overal', 'timing'=>
    'timeing', 'committees'=> 'comittees commitees', 'queries'=> 'quies',
    'econometric'=> 'economtric', 'erroneous'=> 'errounous', 'decides'=> 'descides',
    'reference'=> 'refereence refference', 'intelligence'=> 'inteligence',
    'edition'=> 'ediion ediition', 'are'=> 'arte', 'apologies'=> 'appologies',
    'thermawear'=> 'thermawere thermawhere', 'techniques'=> 'tecniques',
    'voluntary'=> 'volantary', 'subsequent'=> 'subsequant subsiquent', 'currently'=>
    'curruntly', 'forecast'=> 'forcast', 'weapons'=> 'wepons', 'routine'=> 'rouint',
    'neither'=> 'niether', 'approach'=> 'aproach', 'available'=> 'availble',
    'recently'=> 'reciently', 'ability'=> 'ablity', 'nature'=> 'natior',
    'commercial'=> 'comersial', 'agencies'=> 'agences', 'however'=> 'howeverr',
    'suggested'=> 'sugested', 'career'=> 'carear', 'many'=> 'mony', 'annual'=>
    'anual', 'according'=> 'acording', 'receives'=> 'recives recieves',
    'interesting'=> 'intresting', 'expense'=> 'expence', 'relevant'=>
    'relavent relevaant', 'table'=> 'tasble', 'throughout'=> 'throuout', 'conference'=>
    'conferance', 'sensible'=> 'sensable', 'described'=> 'discribed describd',
    'union'=> 'unioun', 'interest'=> 'intrest', 'flexible'=> 'flexable', 'refered'=>
    'reffered', 'controlled'=> 'controled', 'sufficient'=> 'suficient',
    'dissension'=> 'desention', 'adaptable'=> 'adabtable', 'representative'=>
    'representitive', 'irrelevant'=> 'irrelavent', 'unnecessarily'=> 'unessasarily',
    'applied'=> 'upplied', 'apologised'=> 'appologised', 'these'=> 'thees thess',
    'choices'=> 'choises', 'will'=> 'wil', 'procedure'=> 'proceduer', 'shortened'=>
    'shortend', 'manually'=> 'manualy', 'disappointing'=> 'dissapoiting',
    'excessively'=> 'exessively', 'comments'=> 'coments', 'containing'=> 'containg',
    'develop'=> 'develope', 'credit'=> 'creadit', 'government'=> 'goverment',
    'acquaintances'=> 'aquantences', 'orientated'=> 'orentated', 'widely'=> 'widly',
    'advise'=> 'advice', 'difficult'=> 'dificult', 'investigated'=> 'investegated',
    'bonus'=> 'bonas', 'conceived'=> 'concieved', 'nationally'=> 'nationaly',
    'compared'=> 'comppared compased', 'moving'=> 'moveing', 'necessity'=>
    'nessesity', 'opportunity'=> 'oppertunity oppotunity opperttunity', 'thoughts'=>
    'thorts', 'equalled'=> 'equaled', 'variety'=> 'variatry', 'analysis'=>
    'analiss analsis analisis', 'patterns'=> 'pattarns', 'qualities'=> 'quaties', 'easily'=>
    'easyly', 'organization'=> 'oranisation oragnisation', 'the'=> 'thw hte thi',
    'corporate'=> 'corparate', 'composed'=> 'compossed', 'enormously'=> 'enomosly',
    'financially'=> 'financialy', 'functionally'=> 'functionaly', 'discipline'=>
    'disiplin', 'announcement'=> 'anouncement', 'progresses'=> 'progressess',
    'except'=> 'excxept', 'recommending'=> 'recomending', 'mathematically'=>
    'mathematicaly', 'source'=> 'sorce', 'combine'=> 'comibine', 'input'=> 'inut',
    'careers'=> 'currers carrers', 'resolved'=> 'resoved', 'demands'=> 'diemands',
    'unequivocally'=> 'unequivocaly', 'suffering'=> 'suufering', 'immediately'=>
    'imidatly imediatly', 'accepted'=> 'acepted', 'projects'=> 'projeccts',
    'necessary'=> 'necasery nessasary nessisary neccassary', 'journalism'=>
    'journaism', 'unnecessary'=> 'unessessay', 'night'=> 'nite', 'output'=>
    'oputput', 'security'=> 'seurity', 'essential'=> 'esential', 'beneficial'=>
    'benificial benficial', 'explaining'=> 'explaning', 'supplementary'=>
    'suplementary', 'questionnaire'=> 'questionare', 'employment'=> 'empolyment',
    'proceeding'=> 'proceding', 'decision'=> 'descisions descision', 'per'=> 'pere',
    'discretion'=> 'discresion', 'reaching'=> 'reching', 'analysed'=> 'analised',
    'expansion'=> 'expanion', 'although'=> 'athough', 'subtract'=> 'subtrcat',
    'analysing'=> 'aalysing', 'comparison'=> 'comparrison', 'months'=> 'monthes',
    'hierarchal'=> 'hierachial', 'misleading'=> 'missleading', 'commit'=> 'comit',
    'auguments'=> 'aurgument', 'within'=> 'withing', 'obtaining'=> 'optaning',
    'accounts'=> 'acounts', 'primarily'=> 'pimarily', 'operator'=> 'opertor',
    'accumulated'=> 'acumulated', 'extremely'=> 'extreemly', 'there'=> 'thear',
    'summarys'=> 'sumarys', 'analyse'=> 'analiss', 'understandable'=>
    'understadable', 'safeguard'=> 'safegaurd', 'consist'=> 'consisit',
    'declarations'=> 'declaratrions', 'minutes'=> 'muinutes muiuets', 'associated'=>
    'assosiated', 'accessibility'=> 'accessability', 'examine'=> 'examin',
    'surveying'=> 'servaying', 'politics'=> 'polatics', 'annoying'=> 'anoying',
    'again'=> 'agiin', 'assessing'=> 'accesing', 'ideally'=> 'idealy', 'scrutinized'=>
    'scrutiniesed', 'simular'=> 'similar', 'personnel'=> 'personel', 'whereas'=>
    'wheras', 'when'=> 'whn', 'geographically'=> 'goegraphicaly', 'gaining'=>
    'ganing', 'requested'=> 'rquested', 'separate'=> 'seporate', 'students'=>
    'studens', 'prepared'=> 'prepaired', 'generated'=> 'generataed', 'graphically'=>
    'graphicaly', 'suited'=> 'suted', 'variable'=> 'varible vaiable', 'building'=>
    'biulding', 'required'=> 'reequired', 'necessitates'=> 'nessisitates',
    'together'=> 'togehter', 'profits'=> 'proffits'}

  
  def count_mistakes(corpus)
    mistakes = 0
    spellchecker = Spellchecker.new
    corpus.each do |word, misspellings|
      misspellings.split(' ').each do |misspelling|
        correction = spellchecker.correct(misspelling)
        mistakes+=1 if (correction != word)
      end
    end
    mistakes
  end

  should "have 68 errors in first corpus" do
    assert_equal 68, count_mistakes(CORPUS1)
  end

  should "have 130 errors in second corpus" do
    assert_equal 130, count_mistakes(CORPUS2)
  end

end