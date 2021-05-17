import 'package:flutter/cupertino.dart';

class FileIcon extends StatelessWidget {
  final String fileType;
  final double? size;

  FileIcon(String fileName, {this.size})
      : this.fileType = '.' + fileName.split('.').last.toLowerCase();

  @override
  Widget build(BuildContext context) {
    return Icon(
      IconData(
        _iconSetMap[fileType] != null && _iconSetMap.containsKey(fileType)
            ? _iconSetMap[fileType]!.codePoint
            : _iconSetMap['.txt']!.codePoint,
        fontFamily: 'Seti',
      ),
      color: Color(
        _iconSetMap[fileType] != null && _iconSetMap.containsKey(fileType)
            ? _iconSetMap[fileType]!.color
            : _iconSetMap['.txt']!.color,
      ),
      size: size,
    );
  }
}

class _FileIconMeta {
  final int codePoint;
  final int color;
  const _FileIconMeta(this.codePoint, this.color);
}

const _iconSetMap = {
  '.bsl': _FileIconMeta(_bsl, _red),
  '.mdo': _FileIconMeta(_mdo, _red),
  '.asm': _FileIconMeta(_asm, _red),
  '.s': _FileIconMeta(_asm, _red),
  '.c': _FileIconMeta(_c, _blue),
  '.h': _FileIconMeta(_c, _purple),
  '.m': _FileIconMeta(_c, _yellow),
  '.cs': _FileIconMeta(_c_sharp, _blue),
  '.cshtml': _FileIconMeta(_html, _blue),
  '.aspx': _FileIconMeta(_html, _blue),
  '.ascx': _FileIconMeta(_html, _green),
  '.asax': _FileIconMeta(_html, _yellow),
  '.master': _FileIconMeta(_html, _yellow),
  '.cc': _FileIconMeta(_cpp, _blue),
  '.cpp': _FileIconMeta(_cpp, _blue),
  '.cxx': _FileIconMeta(_cpp, _blue),
  '.hh': _FileIconMeta(_cpp, _purple),
  '.hpp': _FileIconMeta(_cpp, _purple),
  '.hxx': _FileIconMeta(_cpp, _purple),
  '.mm': _FileIconMeta(_cpp, _yellow),
  '.clj': _FileIconMeta(_clojure, _green),
  '.cljs': _FileIconMeta(_clojure, _green),
  '.cljc': _FileIconMeta(_clojure, _green),
  '.edn': _FileIconMeta(_clojure, _blue),
  '.cfc': _FileIconMeta(_coldfusion, _blue),
  '.cfm': _FileIconMeta(_coldfusion, _blue),
  '.coffee': _FileIconMeta(_coffee, _yellow),
  '.config': _FileIconMeta(_config, _grey_light),
  '.cfg': _FileIconMeta(_config, _grey_light),
  '.conf': _FileIconMeta(_config, _grey_light),
  '.cr': _FileIconMeta(_crystal, _white),
  '.ecr': _FileIconMeta(_crystal_embedded, _white),
  '.slang': _FileIconMeta(_crystal_embedded, _white),
  '.cson': _FileIconMeta(_json, _yellow),
  '.css': _FileIconMeta(_css, _blue),
  '.css.map': _FileIconMeta(_css, _blue),
  '.sss': _FileIconMeta(_css, _blue),
  '.csv': _FileIconMeta(_csv, _green),
  '.xls': _FileIconMeta(_xls, _green),
  '.xlsx': _FileIconMeta(_xls, _green),
  '.cake': _FileIconMeta(_cake, _red),
  '.ctp': _FileIconMeta(_cake_php, _red),
  '.d': _FileIconMeta(_d, _red),
  '.doc': _FileIconMeta(_word, _blue),
  '.docx': _FileIconMeta(_word, _blue),
  '.ejs': _FileIconMeta(_ejs, _yellow),
  '.ex': _FileIconMeta(_elixir, _purple),
  '.exs': _FileIconMeta(_elixir_script, _purple),
  'mix': _FileIconMeta(_hex, _red),
  '.elm': _FileIconMeta(_elm, _blue),
  '.ico': _FileIconMeta(_favicon, _yellow),
  '.fs': _FileIconMeta(_f_sharp, _blue),
  '.fsx': _FileIconMeta(_f_sharp, _blue),
  '.gitignore': _FileIconMeta(_git, _ignore),
  '.gitconfig': _FileIconMeta(_git, _ignore),
  '.gitkeep': _FileIconMeta(_git, _ignore),
  '.gitattributes': _FileIconMeta(_git, _ignore),
  '.gitmodules': _FileIconMeta(_git, _ignore),
  '.go': _FileIconMeta(_go2, _blue),
  '.slide': _FileIconMeta(_go, _blue),
  '.article': _FileIconMeta(_go, _blue),
  '.gradle': _FileIconMeta(_gradle, _green),
  '.groovy': _FileIconMeta(_grails, _green),
  '.gsp': _FileIconMeta(_grails, _green),
  '.gql': _FileIconMeta(_graphql, _pink),
  '.graphql': _FileIconMeta(_graphql, _pink),
  '.haml': _FileIconMeta(_haml, _red),
  '.handlebars': _FileIconMeta(_mustache, _orange),
  '.hbs': _FileIconMeta(_mustache, _orange),
  '.hjs': _FileIconMeta(_mustache, _orange),
  '.hs': _FileIconMeta(_haskell, _purple),
  '.lhs': _FileIconMeta(_haskell, _purple),
  '.hx': _FileIconMeta(_haxe, _orange),
  '.hxs': _FileIconMeta(_haxe, _yellow),
  '.hxp': _FileIconMeta(_haxe, _blue),
  '.hxml': _FileIconMeta(_haxe, _purple),
  '.html': _FileIconMeta(_html, _orange),
  '.jade': _FileIconMeta(_jade, _red),
  '.java': _FileIconMeta(_java, _red),
  '.class': _FileIconMeta(_java, _red),
  '.classpath': _FileIconMeta(_java, _red),
  '.properties': _FileIconMeta(_java, _red),
  '.js': _FileIconMeta(_javascript, _yellow),
  '.js.map': _FileIconMeta(_javascript, _yellow),
  '.spec.js': _FileIconMeta(_javascript, _orange),
  '.test.js': _FileIconMeta(_javascript, _orange),
  '.es': _FileIconMeta(_javascript, _yellow),
  '.es5': _FileIconMeta(_javascript, _yellow),
  '.es6': _FileIconMeta(_javascript, _yellow),
  '.es7': _FileIconMeta(_javascript, _yellow),
  '.jinja': _FileIconMeta(_jinja, _red),
  '.jinja2': _FileIconMeta(_jinja, _red),
  '.json': _FileIconMeta(_json, _yellow),
  '.jl': _FileIconMeta(_julia, _purple),
  'karma.conf.js': _FileIconMeta(_karma, _green),
  'karma.conf.coffee': _FileIconMeta(_karma, _green),
  '.kt': _FileIconMeta(_kotlin, _orange),
  '.kts': _FileIconMeta(_kotlin, _orange),
  '.dart': _FileIconMeta(_dart, _blue),
  '.less': _FileIconMeta(_less, _blue),
  '.liquid': _FileIconMeta(_liquid, _green),
  '.ls': _FileIconMeta(_livescript, _blue),
  '.lua': _FileIconMeta(_lua, _blue),
  '.markdown': _FileIconMeta(_markdown, _blue),
  '.md': _FileIconMeta(_markdown, _blue),
  '.argdown': _FileIconMeta(_argdown, _blue),
  '.ad': _FileIconMeta(_argdown, _blue),
  'readme.md': _FileIconMeta(_info, _blue),
  'changelog.md': _FileIconMeta(_clock, _blue),
  'changelog': _FileIconMeta(_clock, _blue),
  'changes.md': _FileIconMeta(_clock, _blue),
  'version.md': _FileIconMeta(_clock, _blue),
  'version': _FileIconMeta(_clock, _blue),
  'mvnw': _FileIconMeta(_maven, _red),
  '.mustache': _FileIconMeta(_mustache, _orange),
  '.stache': _FileIconMeta(_mustache, _orange),
  '.njk': _FileIconMeta(_nunjucks, _green),
  '.nunjucks': _FileIconMeta(_nunjucks, _green),
  '.nunjs': _FileIconMeta(_nunjucks, _green),
  '.nunj': _FileIconMeta(_nunjucks, _green),
  '.njs': _FileIconMeta(_nunjucks, _green),
  '.nj': _FileIconMeta(_nunjucks, _green),
  '.npm-debug.log': _FileIconMeta(_npm, _ignore),
  '.npmignore': _FileIconMeta(_npm, _red),
  '.npmrc': _FileIconMeta(_npm, _red),
  '.ml': _FileIconMeta(_ocaml, _orange),
  '.mli': _FileIconMeta(_ocaml, _orange),
  '.cmx': _FileIconMeta(_ocaml, _orange),
  '.cmxa': _FileIconMeta(_ocaml, _orange),
  '.odata': _FileIconMeta(_odata, _orange),
  '.pl': _FileIconMeta(_perl, _blue),
  '.php': _FileIconMeta(_php, _purple),
  '.php.inc': _FileIconMeta(_php, _purple),
  '.pddl': _FileIconMeta(_pddl, _purple),
  '.plan': _FileIconMeta(_plan, _green),
  '.happenings': _FileIconMeta(_happenings, _blue),
  '.ps1': _FileIconMeta(_powershell, _blue),
  '.psd1': _FileIconMeta(_powershell, _blue),
  '.psm1': _FileIconMeta(_powershell, _blue),
  '.pug': _FileIconMeta(_pug, _red),
  '.pp': _FileIconMeta(_puppet, _yellow),
  '.epp': _FileIconMeta(_puppet, _yellow),
  '.py': _FileIconMeta(_python, _blue),
  '.jsx': _FileIconMeta(_react, _blue),
  '.spec.jsx': _FileIconMeta(_react, _orange),
  '.test.jsx': _FileIconMeta(_react, _orange),
  '.cjsx': _FileIconMeta(_react, _blue),
  '.tsx': _FileIconMeta(_react, _blue),
  '.spec.tsx': _FileIconMeta(_react, _yellow),
  '.test.tsx': _FileIconMeta(_react, _yellow),
  '.re': _FileIconMeta(_reasonml, _red),
  '.r': _FileIconMeta(_r, _blue),
  '.rb': _FileIconMeta(_ruby, _red),
  '.erb': _FileIconMeta(_html_erb, _red),
  '.erb.html': _FileIconMeta(_html_erb, _red),
  '.html.erb': _FileIconMeta(_html_erb, _red),
  '.rs': _FileIconMeta(_rust, _grey_light),
  '.sass': _FileIconMeta(_sass, _pink),
  '.scss': _FileIconMeta(_sass, _pink),
  '.springbeans': _FileIconMeta(_spring, _green),
  '.slim': _FileIconMeta(_slim, _orange),
  '.smarty.tpl': _FileIconMeta(_smarty, _yellow),
  '.sbt': _FileIconMeta(_sbt, _blue),
  '.scala': _FileIconMeta(_scala, _red),
  '.sol': _FileIconMeta(_ethereum, _blue),
  '.styl': _FileIconMeta(_stylus, _green),
  '.swift': _FileIconMeta(_swift, _orange),
  '.sql': _FileIconMeta(_db, _pink),
  '.tf': _FileIconMeta(_terraform, _purple),
  '.tf.json': _FileIconMeta(_terraform, _purple),
  '.tfvars': _FileIconMeta(_terraform, _purple),
  '.tex': _FileIconMeta(_tex, _blue),
  '.sty': _FileIconMeta(_tex, _yellow),
  '.dtx': _FileIconMeta(_tex, _orange),
  '.ins': _FileIconMeta(_tex, _white),
  '.txt': _FileIconMeta(_default, _white),
  '.toml': _FileIconMeta(_config, _grey_light),
  '.twig': _FileIconMeta(_twig, _green),
  '.ts': _FileIconMeta(_typescript, _blue),
  '.spec.ts': _FileIconMeta(_typescript, _yellow),
  '.test.ts': _FileIconMeta(_typescript, _yellow),
  'tsconfig.json': _FileIconMeta(_tsconfig, _blue),
  '.vala': _FileIconMeta(_vala, _grey_light),
  '.vapi': _FileIconMeta(_vala, _grey_light),
  '.vue': _FileIconMeta(_vue, _green),
  '.wasm': _FileIconMeta(_wasm, _purple),
  '.wat': _FileIconMeta(_wat, _purple),
  '.xml': _FileIconMeta(_xml, _orange),
  '.yml': _FileIconMeta(_yml, _purple),
  '.yaml': _FileIconMeta(_yml, _purple),
  'swagger.json': _FileIconMeta(_json, _green),
  'swagger.yml': _FileIconMeta(_json, _green),
  'swagger.yaml': _FileIconMeta(_json, _green),
  '.jar': _FileIconMeta(_zip, _red),
  '.zip': _FileIconMeta(_zip, _grey_light),
  '.wgt': _FileIconMeta(_wgt, _blue),
  '.ai': _FileIconMeta(_illustrator, _yellow),
  '.psd': _FileIconMeta(_photoshop, _blue),
  '.pdf': _FileIconMeta(_pdf, _red),
  '.eot': _FileIconMeta(_font, _red),
  '.ttf': _FileIconMeta(_font, _red),
  '.woff': _FileIconMeta(_font, _red),
  '.woff2': _FileIconMeta(_font, _red),
  '.gif': _FileIconMeta(_image, _purple),
  '.jpg': _FileIconMeta(_image, _purple),
  '.jpeg': _FileIconMeta(_image, _purple),
  '.png': _FileIconMeta(_image, _purple),
  '.pxm': _FileIconMeta(_image, _purple),
  '.svg': _FileIconMeta(_svg, _purple),
  '.svgx': _FileIconMeta(_image, _purple),
  '.sublime-project': _FileIconMeta(_sublime, _orange),
  '.sublime-workspace': _FileIconMeta(_sublime, _orange),
  '.code-search': _FileIconMeta(_code_search, _purple),
  '.component': _FileIconMeta(_salesforce, _blue),
  '.cls': _FileIconMeta(_salesforce, _blue),
  '.sh': _FileIconMeta(_shell, _grey),
  '.zsh': _FileIconMeta(_shell, _grey),
  '.fish': _FileIconMeta(_shell, _grey),
  '.zshrc': _FileIconMeta(_shell, _grey),
  '.bashrc': _FileIconMeta(_shell, _grey),
  '.mov': _FileIconMeta(_video, _pink),
  '.ogv': _FileIconMeta(_video, _pink),
  '.webm': _FileIconMeta(_video, _pink),
  '.avi': _FileIconMeta(_video, _pink),
  '.mpg': _FileIconMeta(_video, _pink),
  '.mp4': _FileIconMeta(_video, _pink),
  '.mp3': _FileIconMeta(_audio, _purple),
  '.ogg': _FileIconMeta(_audio, _purple),
  '.wav': _FileIconMeta(_audio, _purple),
  '.flac': _FileIconMeta(_audio, _purple),
  '.3ds': _FileIconMeta(_svg, _blue),
  '.3dm': _FileIconMeta(_svg, _blue),
  '.stl': _FileIconMeta(_svg, _blue),
  '.obj': _FileIconMeta(_svg, _blue),
  '.dae': _FileIconMeta(_svg, _blue),
  '.bat': _FileIconMeta(_windows, _blue),
  '.cmd': _FileIconMeta(_windows, _blue),
  'mime.types': _FileIconMeta(_config, _grey_light),
  'jenkinsfile': _FileIconMeta(_jenkins, _red),
  '.babelrc': _FileIconMeta(_babel, _yellow),
  'bower.json': _FileIconMeta(_bower, _orange),
  '.bowerrc': _FileIconMeta(_bower, _orange),
  'dockerfile': _FileIconMeta(_docker, _blue),
  '.dockerignore': _FileIconMeta(_docker, _grey),
  'docker-healthcheck': _FileIconMeta(_docker, _green),
  'docker-compose.yml': _FileIconMeta(_docker, _pink),
  'docker-compose.yaml': _FileIconMeta(_docker, _pink),
  'docker-compose.override.yml': _FileIconMeta(_docker, _pink),
  'docker-compose.override.yaml': _FileIconMeta(_docker, _pink),
  '.codeclimate.yml': _FileIconMeta(_code_climate, _green),
  '.eslintrc': _FileIconMeta(_eslint, _purple),
  '.eslintrc.js': _FileIconMeta(_eslint, _purple),
  '.eslintrc.yaml': _FileIconMeta(_eslint, _purple),
  '.eslintrc.yml': _FileIconMeta(_eslint, _purple),
  '.eslintrc.json': _FileIconMeta(_eslint, _purple),
  '.eslintignore': _FileIconMeta(_eslint, _grey),
  '.firebaserc': _FileIconMeta(_firebase, _orange),
  'firebase.json': _FileIconMeta(_firebase, _orange),
  'geckodriver': _FileIconMeta(_firefox, _orange),
  'gruntfile.js': _FileIconMeta(_grunt, _orange),
  'gruntfile.babel.js': _FileIconMeta(_grunt, _orange),
  'gruntfile.coffee': _FileIconMeta(_grunt, _orange),
  'gulpfile': _FileIconMeta(_gulp, _red),
  'ionic.config.json': _FileIconMeta(_ionic, _blue),
  'ionic.project': _FileIconMeta(_ionic, _blue),
  '.jshintrc': _FileIconMeta(_javascript, _blue),
  '.jscsrc': _FileIconMeta(_javascript, _blue),
  'platformio.ini': _FileIconMeta(_platformio, _orange),
  'rollup.config.js': _FileIconMeta(_rollup, _red),
  'sass-lint.yml': _FileIconMeta(_sass, _pink),
  '.stylelintrc': _FileIconMeta(_stylelint, _white),
  '.stylelintrc.json': _FileIconMeta(_stylelint, _white),
  '.stylelintrc.yaml': _FileIconMeta(_stylelint, _white),
  '.stylelintrc.yml': _FileIconMeta(_stylelint, _white),
  '.stylelintrc.js': _FileIconMeta(_stylelint, _white),
  '.stylelintignore': _FileIconMeta(_stylelint, _grey),
  'stylelint.config.js': _FileIconMeta(_stylelint, _white),
  'yarn.clean': _FileIconMeta(_yarn, _blue),
  'yarn.lock': _FileIconMeta(_yarn, _blue),
  'webpack.config.js': _FileIconMeta(_webpack, _blue),
  'webpack.config.build.js': _FileIconMeta(_webpack, _blue),
  'webpack.common.js': _FileIconMeta(_webpack, _blue),
  'webpack.dev.js': _FileIconMeta(_webpack, _blue),
  'webpack.prod.js': _FileIconMeta(_webpack, _blue),
  '.direnv': _FileIconMeta(_config, _grey_light),
  '.env': _FileIconMeta(_config, _grey_light),
  '.static': _FileIconMeta(_config, _grey_light),
  '.editorconfig': _FileIconMeta(_config, _grey_light),
  '.slugignore': _FileIconMeta(_config, _grey_light),
  '.tmp': _FileIconMeta(_clock, _grey_light),
  '.htaccess': _FileIconMeta(_config, _grey_light),
  '.key': _FileIconMeta(_lock, _green),
  '.cert': _FileIconMeta(_lock, _green),
  'license': _FileIconMeta(_license, _yellow),
  'licence': _FileIconMeta(_license, _yellow),
  'copying': _FileIconMeta(_license, _yellow),
  'compiling': _FileIconMeta(_license, _orange),
  'contributing': _FileIconMeta(_license, _red),
  'makefile': _FileIconMeta(_makefile, _orange),
  'qmakefile': _FileIconMeta(_makefile, _purple),
  'omakefile': _FileIconMeta(_makefile, _grey_light),
  'cmakelists.txt': _FileIconMeta(_makefile, _blue),
  'procfile': _FileIconMeta(_heroku, _purple),
  'todo': _FileIconMeta(_todo, _seti_primary),
  'npm-debug.log': _FileIconMeta(_npm_ignored, _ignore),
  '.ds_store': _FileIconMeta(_ignored, _ignore),
};

const _r = 0xE001;
const _argdown = 0xE003;
const _asm = 0xE004;
const _audio = 0xE005;
const _babel = 0xE006;
const _bower = 0xE007;
const _bsl = 0xE008;
const _c_sharp = 0xE009;
const _c = 0xE00A;
const _cake = 0xE00B;
const _cake_php = 0xE00C;
const _clock = 0xE010;
const _clojure = 0xE011;
const _code_climate = 0xE012;
const _code_search = 0xE013;
const _coffee = 0xE014;
const _coldfusion = 0xE016;
const _config = 0xE017;
const _cpp = 0xE018;
const _crystal = 0xE019;
const _crystal_embedded = 0xE01A;
const _css = 0xE01B;
const _csv = 0xE01C;
const _d = 0xE01D;
const _dart = 0xE01E;
const _db = 0xE01F;
const _default = 0xE020;
const _docker = 0xE022;
const _ejs = 0xE024;
const _elixir = 0xE025;
const _elixir_script = 0xE026;
const _elm = 0xE027;
const _eslint = 0xE029;
const _ethereum = 0xE02A;
const _f_sharp = 0xE02B;
const _favicon = 0xE02C;
const _firebase = 0xE02D;
const _firefox = 0xE02E;
const _font = 0xE030;
const _git = 0xE031;
const _go = 0xE035;
const _go2 = 0xE036;
const _gradle = 0xE037;
const _grails = 0xE038;
const _graphql = 0xE039;
const _grunt = 0xE03A;
const _gulp = 0xE03B;
const _haml = 0xE03D;
const _happenings = 0xE03E;
const _haskell = 0xE03F;
const _haxe = 0xE040;
const _heroku = 0xE041;
const _hex = 0xE042;
const _html = 0xE043;
const _html_erb = 0xE044;
const _ignored = 0xE045;
const _illustrator = 0xE046;
const _image = 0xE047;
const _info = 0xE048;
const _ionic = 0xE049;
const _jade = 0xE04A;
const _java = 0xE04B;
const _javascript = 0xE04C;
const _jenkins = 0xE04D;
const _jinja = 0xE04E;
const _json = 0xE050;
const _julia = 0xE051;
const _karma = 0xE052;
const _kotlin = 0xE053;
const _less = 0xE054;
const _license = 0xE055;
const _liquid = 0xE056;
const _livescript = 0xE057;
const _lock = 0xE058;
const _lua = 0xE059;
const _makefile = 0xE05A;
const _markdown = 0xE05B;
const _maven = 0xE05C;
const _mdo = 0xE05D;
const _mustache = 0xE05E;
const _npm = 0xE060;
const _npm_ignored = 0xE061;
const _nunjucks = 0xE062;
const _ocaml = 0xE063;
const _odata = 0xE064;
const _pddl = 0xE065;
const _pdf = 0xE066;
const _perl = 0xE067;
const _photoshop = 0xE068;
const _php = 0xE069;
const _plan = 0xE06A;
const _platformio = 0xE06B;
const _powershell = 0xE06C;
const _pug = 0xE06E;
const _puppet = 0xE06F;
const _python = 0xE070;
const _react = 0xE072;
const _reasonml = 0xE073;
const _rollup = 0xE074;
const _ruby = 0xE075;
const _rust = 0xE076;
const _salesforce = 0xE077;
const _sass = 0xE078;
const _sbt = 0xE079;
const _scala = 0xE07A;
const _shell = 0xE07D;
const _slim = 0xE07E;
const _smarty = 0xE07F;
const _spring = 0xE080;
const _stylelint = 0xE081;
const _stylus = 0xE082;
const _sublime = 0xE083;
const _svg = 0xE084;
const _swift = 0xE085;
const _terraform = 0xE086;
const _tex = 0xE087;
const _todo = 0xE089;
const _tsconfig = 0xE08A;
const _twig = 0xE08B;
const _typescript = 0xE08C;
const _vala = 0xE08D;
const _video = 0xE08E;
const _vue = 0xE08F;
const _wasm = 0xE090;
const _wat = 0xE091;
const _webpack = 0xE092;
const _wgt = 0xE093;
const _windows = 0xE094;
const _word = 0xE095;
const _xls = 0xE096;
const _xml = 0xE097;
const _yarn = 0xE098;
const _yml = 0xE099;
const _zip = 0xE09A;
const _white = 0xffd4d7d6;
const _grey = 0xff4d5a5e;
const _grey_light = 0xff6d8086;
const _blue = 0xff519aba;
const _green = 0xff8dc149;
const _orange = 0xffe37933;
const _pink = 0xfff55385;
const _purple = 0xffa074c4;
const _red = 0xffcc3e44;
const _yellow = 0xffcbcb41;
const _ignore = 0xff41535b;
const _seti_primary = _blue;

// final List<String> files =
//     _iconSetMap.keys.map((e) => 'https://pythagon.com/filename$e').toList();
