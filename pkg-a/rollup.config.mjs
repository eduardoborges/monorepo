import esbuild from 'rollup-plugin-esbuild';
import postcss from 'rollup-plugin-postcss';
import dts from 'rollup-plugin-dts'

/** @type import('rollup').RollupOptions[] */
export default [
  {
    input: 'src/index.ts',
    external: ['react', 'react-dom', 'react/jsx-runtime'],
    plugins: [
      postcss({
        extract: false,
        modules: true,
        use: {
          sass: {
            includePaths: ['node_modules'],
          },
        },
      }),
      esbuild({
        include: /\.[jt]sx?$/,
      })
    ],
    output: [
      { file: 'dist/index.js', format: 'es' },
      { file: 'dist/index.cjs', format: 'cjs' },
    ],
  },
  {
    input: "src/index.ts",
    output: [{ file: "dist/index.d.ts", format: "es" }],
    plugins: [dts()],
  }
];
